class ClaudeCodeSwitch < Formula
  desc "Minimal provider switching for Claude Code"
  homepage "https://github.com/maxgfr/claude-code-switch"
  url "https://github.com/maxgfr/claude-code-switch/archive/refs/tags/v1.8.2.tar.gz"
  version "v1.8.2"
  sha256 "a3b399b22bbfa81cd91e2988f25adae23c7e5d1aa4a571c4c62f0c4bd06d4f15"
  license "MIT"

  # Needed by `ccs notify` (desktop notifications)
  depends_on "jq"
  # Supplies the real context window per model, so auto-compact stops assuming 200k
  depends_on "maxgfr/tap/llm-models"

  def install
    bin.install "ccs"
    bin.install_symlink bin/"ccs" => "claude-code-switch"
    pkgshare.install "config.template"
    doc.install "README.md", "LICENSE", "CHANGELOG.md", "CONTRIBUTING.md"
  end

  def caveats
    <<~EOS
      Context windows are sized automatically from llm-models. Run `ccs models`
      to see what each model tier resolves to, or pin a value with
      `context_tokens=` in ~/.claude-provider/config.
    EOS
  end

  test do
    system "#{bin}/ccs", "--version"
  end
end
