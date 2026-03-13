class GitRecap < Formula
  desc "Monthly commit recap generator — AI-powered summaries and bullet points"
  homepage "https://github.com/maxgfr/git-recap"
  url "https://github.com/maxgfr/git-recap/archive/refs/tags/v1.4.0.tar.gz"
  version "v1.4.0"
  sha256 "6a26099e6200a8013217384ab1150d97e181893f8934499815f4f55c067b89f3"
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
