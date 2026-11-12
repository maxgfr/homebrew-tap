class GitRecap < Formula
  desc "Generate monthly commit recaps with AI summaries and bullet points"
  homepage "https://github.com/maxgfr/git-recap"
  url "https://github.com/maxgfr/git-recap/archive/refs/tags/v2.0.4.tar.gz"
  sha256 "bcdadca6b856014518529355947671e079bd4a9deba04e33de7489dd56aa6b89"
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
