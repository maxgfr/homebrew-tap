class GitPilot < Formula
  desc "Automate git with AI-written commits, conflict resolution and auto-rebase"
  homepage "https://github.com/maxgfr/git-pilot"
  url "https://github.com/maxgfr/git-pilot/archive/refs/tags/v2.3.0.tar.gz"
  sha256 "933298d5b8686bfe91c3ad26d02373e492086e7a1f002de6fc9f0e937943141e"
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
