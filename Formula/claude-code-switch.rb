class ClaudeCodeSwitch < Formula
  desc "Minimal, zero-dependency provider switching for Claude Code"
  homepage "https://github.com/maxgfr/claude-code-switch"
  url "https://github.com/maxgfr/claude-code-switch/archive/refs/tags/v1.2.0.tar.gz"
  version "v1.2.0"
  sha256 "afbb6f5dc1b75802c6b8cb79aaa6f4800b7fd28291d89d983dc6f3dc71e54a27"
  license "MIT"

  # Only needed by `ccs notify` (desktop notifications); the core is zero-dependency
  depends_on "jq"

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
