class ClaudeCodeSwitch < Formula
  desc "Minimal, zero-dependency provider switching for Claude Code"
  homepage "https://github.com/maxgfr/claude-code-switch"
  url "https://github.com/maxgfr/claude-code-switch/archive/refs/tags/v1.3.1.tar.gz"
  version "v1.3.1"
  sha256 "6b703d7572354ebc6122967d83459b777cf95da68cc411d2d21a5b96cfe2fe7b"
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
