class ClaudeCodeSwitch < Formula
  desc "Minimal, zero-dependency provider switching for Claude Code"
  homepage "https://github.com/maxgfr/claude-code-switch"
  url "https://github.com/maxgfr/claude-code-switch/archive/refs/tags/v1.0.0.tar.gz"
  version "v1.0.0"
  sha256 "b9c580e3ba589cb21e06e369617cb7c753dbbcc7a8eef659ef7c539f25af807e"
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
