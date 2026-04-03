class ClaudeCodeSwitch < Formula
  desc "Minimal, zero-dependency provider switching for Claude Code"
  homepage "https://github.com/maxgfr/claude-code-switch"
  url "https://github.com/maxgfr/claude-code-switch/archive/refs/tags/v1.0.0.tar.gz"
  version "v1.0.0"
  sha256 "38c35c0e06b72f1f51dbdccabe55b27a344a49cb4dd52b3d0d97ac1895b51de9"
  license "MIT"

  def install
    bin.install "ccs" => "ccs"
    bin.install "ccs" => "claude-code-switch"
    pkgshare.install "config.template"
    doc.install "README.md", "LICENSE", "CHANGELOG.md", "CONTRIBUTING.md"
  end

  test do
    system "#{bin}/ccs", "--version"
  end
end
