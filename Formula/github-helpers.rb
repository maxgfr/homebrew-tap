class GithubHelpers < Formula
  desc "GitHub maintenance toolkit: bulk unstar, org clone, and more"
  homepage "https://github.com/maxgfr/github-helpers"
  url "https://github.com/maxgfr/github-helpers/archive/refs/tags/v1.3.0.tar.gz"
  version "v1.3.0"
  sha256 "907582bb2b5a4e511702b068680d7ccc555b0829c5b4c46fc667514246b8c26e"
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
