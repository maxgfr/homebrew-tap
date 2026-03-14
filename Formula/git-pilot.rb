class GitPilot < Formula
  desc "AI-powered git automation: smart commits, conflict resolution, and auto-rebase"
  homepage "https://github.com/maxgfr/git-pilot"
  url "https://github.com/maxgfr/git-pilot/archive/refs/tags/v1.12.0.tar.gz"
  version "v1.12.0"
  sha256 "ef84798e903d13cb9902baed324ddf4a2e4f4ff6fe1569525174ad61708c9eb8"
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
