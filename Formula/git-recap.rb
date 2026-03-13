class GitRecap < Formula
  desc "Monthly commit recap generator — AI-powered summaries and bullet points"
  homepage "https://github.com/maxgfr/git-recap"
  url "https://github.com/maxgfr/git-recap/archive/refs/tags/v1.3.0.tar.gz"
  version "v1.3.0"
  sha256 "7bcbcb879cd53f5ce62581a7281749517998e3095078893b0ac4aacd67aabf39"
  license "MIT"

  depends_on "gh"
  depends_on "git"

  def install
    bin.install "git-recap"
  end

  def caveats
    <<~EOS
      git-recap requires gh to be authenticated: gh auth login
      For AI summaries, install Claude Code CLI: npm install -g @anthropic-ai/claude-code
      Usage: git-recap maxgfr/my-repo
      Also works as: git recap maxgfr/my-repo
    EOS
  end

  test do
    system bin/"git-recap", "--version"
  end
end
