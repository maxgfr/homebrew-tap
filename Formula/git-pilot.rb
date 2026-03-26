class GitPilot < Formula
  desc "AI-powered git automation: smart commits, conflict resolution, and auto-rebase"
  homepage "https://github.com/maxgfr/git-pilot"
  url "https://github.com/maxgfr/git-pilot/archive/refs/tags/v1.12.9.tar.gz"
  version "v1.12.9"
  sha256 "7f49b97783efaf5a1d6b601b0004c946c4b60cdcb2109e47973fcf6e0bb23359"
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
