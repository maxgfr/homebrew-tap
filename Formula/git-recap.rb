class GitRecap < Formula
  desc "Monthly commit recap generator — AI-powered summaries and bullet points"
  homepage "https://github.com/maxgfr/git-recap"
  url "https://github.com/maxgfr/git-recap/archive/refs/tags/v1.5.0.tar.gz"
  version "v1.5.0"
  sha256 "56f3f4f1e15c3cc7e374a439c727966cb1a483ea44a5f7a8a0479cb63f69f9ca"
  license "MIT"

  depends_on "gh"
  depends_on "git"

  def install
    bin.install "git-recap"
  end

  test do
    system bin/"git-recap", "--version"
  end
end
