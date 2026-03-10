class GitPilot < Formula
  desc "AI-powered git automation: smart commits, conflict resolution, and auto-rebase"
  homepage "https://github.com/maxgfr/git-pilot"
  url "https://github.com/maxgfr/git-pilot/archive/refs/tags/v1.7.1.tar.gz"
  version "v1.7.1"
  sha256 "7cb3b4b49c14eef44d69bebcc6313b6347be64aea845b17cdd0557f9138a123b"
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
