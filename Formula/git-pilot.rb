class GitPilot < Formula
  desc "Automate git with AI-written commits, conflict resolution and auto-rebase"
  homepage "https://github.com/maxgfr/git-pilot"
  url "https://github.com/maxgfr/git-pilot/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "2d49216ebc130d114ef955be1f9634eddca0730e87401824c5140cfbffff08bd"
  license "MIT"

  depends_on "curl"
  depends_on "jq"

  def install
    bin.install "script.sh" => "git-pilot"
  end

  test do
    system bin/"git-pilot", "--version"
  end
end
