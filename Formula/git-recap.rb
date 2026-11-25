class GitRecap < Formula
  desc "Generate monthly commit recaps with AI summaries and bullet points"
  homepage "https://github.com/maxgfr/git-recap"
  url "https://github.com/maxgfr/git-recap/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "096161f9be59b45f70a4d063a46a3440db49b7c93ab5e3408f957094fe4d2dbd"
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
