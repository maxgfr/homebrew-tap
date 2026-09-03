class GitRecap < Formula
  desc "Monthly commit recap generator — AI-powered summaries and bullet points"
  homepage "https://github.com/maxgfr/git-recap"
  url "https://github.com/maxgfr/git-recap/archive/refs/tags/v1.7.0.tar.gz"
  version "v1.7.0"
  sha256 "417532ac5ff1eb37f0a2b50be2fa3311f900576457f7882e71fc69349f621b0c"
  license "MIT"

  depends_on "gh"
  depends_on "git"

  def install
    bin.install "script.sh" => "git-recap"
  end

  test do
    system bin/"git-recap", "--version"
  end
end
