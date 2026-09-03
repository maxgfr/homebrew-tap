class GitPilot < Formula
  desc "AI-powered git automation: smart commits, conflict resolution, and auto-rebase"
  homepage "https://github.com/maxgfr/git-pilot"
  url "https://github.com/maxgfr/git-pilot/archive/refs/tags/v1.12.10.tar.gz"
  version "v1.12.10"
  sha256 "04d060acc750b0125e93cf5bd61f4144d6fb297fffbe2a7b62e8bfcf2d862e48"
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
