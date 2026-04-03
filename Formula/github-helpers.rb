class GithubHelpers < Formula
  desc "GitHub maintenance toolkit: bulk unstar, org clone, and more"
  homepage "https://github.com/maxgfr/github-helpers"
  url "https://github.com/maxgfr/github-helpers/archive/refs/tags/v1.1.0.tar.gz"
  version "v1.1.0"
  sha256 "38d5b2d10f12daa7c78321f96e0b4dce30608458a36f0a6ad0d0d3bcd99770f5"
  license "MIT"

  depends_on "gh"
  depends_on "jq"

  def install
    bin.install "script.sh" => "github-helpers"
  end

  test do
    system "#{bin}/github-helpers", "--help"
  end
end
