class ClaudeCodeSwitch < Formula
  desc "Minimal, zero-dependency provider switching for Claude Code"
  homepage "https://github.com/maxgfr/claude-code-switch"
  url "https://github.com/maxgfr/claude-code-switch/archive/refs/tags/v1.2.0.tar.gz"
  version "v1.2.0"
  sha256 "afbb6f5dc1b75802c6b8cb79aaa6f4800b7fd28291d89d983dc6f3dc71e54a27"
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
