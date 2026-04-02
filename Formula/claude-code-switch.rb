class ClaudeCodeSwitch < Formula
  desc "Minimal, zero-dependency provider switching for Claude Code"
  homepage "https://github.com/maxgfr/claude-code-switch"
  url "https://github.com/maxgfr/claude-code-switch/archive/refs/tags/v1.0.0.tar.gz"
  version "v1.0.0"
  sha256 "da7f306f2debf0ea72ed85da4ddb1e81362cf90aaa16f42b14d6a2318a8b5050"
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
