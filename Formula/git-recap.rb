class GitRecap < Formula
  desc "Monthly commit recap generator — AI-powered summaries and bullet points"
  homepage "https://github.com/maxgfr/git-recap"
  url "https://github.com/maxgfr/git-recap/archive/refs/tags/v1.6.2.tar.gz"
  version "v1.6.2"
  sha256 "93af413662a6f464744d2a4c01ef07fa48acd3012a19a0e292af10cb1fed8683"
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
