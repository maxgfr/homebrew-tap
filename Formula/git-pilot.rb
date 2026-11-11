class GitPilot < Formula
  desc "Automate git with AI-written commits, conflict resolution and auto-rebase"
  homepage "https://github.com/maxgfr/git-pilot"
  url "https://github.com/maxgfr/git-pilot/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "de40933f62f6bf96494a2c5559f0f72d6ce9f2aa8f0dadb0d093a160bd08210d"
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
