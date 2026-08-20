class ClaudeCodeSwitch < Formula
  desc "Minimal, zero-dependency provider switching for Claude Code"
  homepage "https://github.com/maxgfr/claude-code-switch"
  url "https://github.com/maxgfr/claude-code-switch/archive/refs/tags/v1.3.0.tar.gz"
  version "v1.3.0"
  sha256 "daa6107956169ca807c19519d5d86d45dc26ceb2643dc8c04916f7b9253ec52f"
  license "MIT"

  # Only needed by `ccs notify` (desktop notifications); the core is zero-dependency
  depends_on "jq"

  def caveats
    <<~EOS
      For automatic context-window sizing (so auto-compact stops assuming 200k on
      a 1M model), also install:

        brew install maxgfr/tap/llm-models

      It is optional — ccs works without it. Run `ccs models` to see what each
      model tier resolves to.
    EOS
  end

  def install
    bin.install "ccs"
    bin.install_symlink bin/"ccs" => "claude-code-switch"
    pkgshare.install "config.template"
    doc.install "README.md", "LICENSE", "CHANGELOG.md", "CONTRIBUTING.md"
  end

  test do
    system "#{bin}/ccs", "--version"
  end
end
