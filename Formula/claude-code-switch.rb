class ClaudeCodeSwitch < Formula
  desc "Minimal, zero-dependency provider switching for Claude Code"
  homepage "https://github.com/maxgfr/claude-code-switch"
  url "https://github.com/maxgfr/claude-code-switch/archive/refs/tags/v1.0.6.tar.gz"
  version "v1.0.6"
  sha256 "b111fa3719d4dc214e3f45ab2a7d73fa115078fba31b84c303f5d50056833c05"
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
