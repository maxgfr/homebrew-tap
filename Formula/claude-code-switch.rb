class ClaudeCodeSwitch < Formula
  desc "Minimal, zero-dependency provider switching for Claude Code"
  homepage "https://github.com/maxgfr/claude-code-switch"
  url "https://github.com/maxgfr/claude-code-switch/archive/refs/tags/v1.0.0.tar.gz"
  version "v1.0.0"
  sha256 "f09a49b9410d80932b19c1489dde9bebfb213557782dbbb12198936b05f64391"
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
