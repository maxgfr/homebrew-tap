class Crible < Formula
  desc "Self-hosted fundamental stock screener with a CLI, an API and an MCP server"
  homepage "https://github.com/maxgfr/crible"
  url "https://github.com/maxgfr/crible/archive/refs/tags/v0.17.0.tar.gz"
  sha256 "19115a2570bbc7ce618c6de6e96effe66ada72988e7d2ac7712004587502f7fe"
  license "MIT"

  # crible is Python (DuckDB, pyarrow, pandas): uv builds its environment from
  # the release's uv.lock, on a Python 3.12 that uv fetches if it has to.
  depends_on "uv"

  def install
    # The package build reads README.md. Homebrew moves the metafiles to the
    # prefix, so the project keeps its own copy.
    cp "README.md", "README.project.md"
    libexec.install "pyproject.toml", "uv.lock", "src"
    libexec.install "README.project.md" => "README.md"
    pkgshare.install "skills"

    # The environment lives in var, not in each user's ~/.cache, so
    # post_install can build it once and every run finds it. A run whose
    # environment is missing or from another version builds it first.
    (bin/"crible").write <<~SH
      #!/bin/bash
      set -euo pipefail
      home="${CRIBLE_HOME:-#{var}/crible}"
      venv="$home/venv"
      stamp="$venv/.crible-#{version}"
      if [[ ! -f "$stamp" ]]; then
        mkdir -p "$home"
        lock="$home/.lock"
        # One build at a time: crible is often started by several processes at once.
        # A lock left over by a killed build (older than 15 minutes) is taken over.
        until mkdir "$lock" 2>/dev/null; do
          if [[ -n "$(find "$lock" -maxdepth 0 -mmin +15 2>/dev/null)" ]]; then rmdir "$lock" 2>/dev/null || true; fi
          sleep 1
        done
        trap 'rmdir "$lock" 2>/dev/null || true' EXIT
        if [[ ! -f "$stamp" ]]; then
          echo "crible: building its environment in $venv (once per version)..." >&2
          UV_PYTHON_INSTALL_DIR="$home/python" UV_CACHE_DIR="$home/uv-cache" UV_NO_PROGRESS=1 \\
            UV_PROJECT_ENVIRONMENT="$venv" "#{formula_opt_bin("uv")}/uv" sync --quiet \\
            --project "#{libexec}" --frozen --no-dev --no-editable --compile-bytecode --python 3.12 >&2
          rm -f "$venv"/.crible-*
          touch "$stamp"
        fi
        rmdir "$lock" 2>/dev/null || true
        trap - EXIT
      fi
      exec "$venv/bin/crible" "$@"
    SH
  end

  # Build the environment now, so the first run starts straight away. If this
  # cannot run (no network), the first run does it.
  post_install_steps do
    run "crible", base: :bin, args: ["--version"],
        writable_paths: ["crible"], writable_base: :var,
        network_access: true, must_succeed: false
  end

  def caveats
    <<~EOS
      crible needs a dataset. Download the published one into a directory:
        crible --data-dir ~/crible bootstrap
      ultrastock uses this crible when it is the version it pins, and uvx otherwise.
      The agent skill is in:
        #{opt_pkgshare}/skills
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/crible --version").strip
    assert_match "screen", shell_output("#{bin}/crible --help")
  end
end
