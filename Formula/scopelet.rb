class Scopelet < Formula
  desc "Compute before you send: local, recoverable evidence queries for agents"
  homepage "https://github.com/maxgfr/scopelet"
  version "0.5.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.5.4/scopelet-aarch64-apple-darwin"
      sha256 "c16490eb80ff912cdd4d90b3cfc00916301d28c6212788f93f39c0169964e561"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.5.4/scopelet-x86_64-apple-darwin"
      sha256 "0d2c7f13906118675e9d44a8c4de9d1aa882d055c0eeafa3eafd6f4deefbda50"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.5.4/scopelet-aarch64-unknown-linux-gnu"
      sha256 "89895faff85193d937a5f1eac631b98f3d6871bb3b215c3e31fc5a27d1880550"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.5.4/scopelet-x86_64-unknown-linux-gnu"
      sha256 "cfce065803b79b0abe4362305b936d18f0edd69e0a40835edc4b9c0018ff26e8"
    end
  end

  def install
    binary = Dir["scopelet-*"].first

    if binary.nil?
      opoo "No scopelet binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "scopelet"
  end

  def caveats
    <<~EOS
      The binary compresses nothing on its own. Install the agent hooks with:

        scopelet install --agent all

      That copies this binary to ~/.config/scopelet/bin/scopelet and points the
      Claude Code, Codex and OpenCode hooks at the copy, so re-run it after every
      brew upgrade scopelet. Check the result with: scopelet doctor

      The model-invocable skill is a separate install:
        npx skills add maxgfr/scopelet --skill scopelet --global -a codex claude-code opencode -y
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scopelet --version")
    # Under the threshold nothing is substituted, so the bytes must come back
    # exactly. A real end-to-end run of the compressor, with no network, no model
    # call and its own cache, rather than a version string echo.
    assert_equal "hello world\n",
                 pipe_output("#{bin}/scopelet compress --cache-dir #{testpath}/cache", "hello world\n")
  end
end
