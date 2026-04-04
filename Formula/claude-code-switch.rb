class ClaudeCodeSwitch < Formula
  desc "Minimal, zero-dependency provider switching for Claude Code"
  homepage "https://github.com/maxgfr/claude-code-switch"
  url "https://github.com/maxgfr/claude-code-switch/archive/refs/tags/v1.0.4.tar.gz"
  version "v1.0.4"
  sha256 "9c2167a7cd1187c229090af2deda8f2b24d4c4d236e0b473d1d7740125de7248"
  license "MIT"

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
