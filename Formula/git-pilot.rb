class GitPilot < Formula
  desc "AI-powered git automation: smart commits, conflict resolution, and auto-rebase"
  homepage "https://github.com/maxgfr/git-pilot"
  url "https://github.com/maxgfr/git-pilot/archive/refs/tags/v1.12.5.tar.gz"
  version "v1.12.5"
  sha256 "a694900d5de99ead7def832db97f4ad5f18e5187f8a5f09e116a3d2bfbb46ea6"
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
