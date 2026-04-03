class ClaudeCodeSwitch < Formula
  desc "Minimal, zero-dependency provider switching for Claude Code"
  homepage "https://github.com/maxgfr/claude-code-switch"
  url "https://github.com/maxgfr/claude-code-switch/archive/refs/tags/v1.0.0.tar.gz"
  version "v1.0.0"
  sha256 "a3d54e633e19b13b81b017ca4af7b2c8c9889aaea8ba5e4f3d16004cb49885c4"
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
