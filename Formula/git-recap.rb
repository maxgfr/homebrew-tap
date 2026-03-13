class GitRecap < Formula
  desc "Monthly commit recap generator — AI-powered summaries and bullet points"
  homepage "https://github.com/maxgfr/git-recap"
  url "https://github.com/maxgfr/git-recap/archive/refs/tags/v1.0.0.tar.gz"
  version "v1.0.0"
  sha256 "99b14b7a605f09ca56d33b30056c6a00411a4e4e544d4b761ca5fbe54873f012"
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
