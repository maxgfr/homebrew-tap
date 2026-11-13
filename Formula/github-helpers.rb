class GithubHelpers < Formula
  desc "Bulk-unstar repos, clone whole orgs and run other GitHub maintenance tasks"
  homepage "https://github.com/maxgfr/github-helpers"
  url "https://github.com/maxgfr/github-helpers/archive/refs/tags/v1.9.0.tar.gz"
  sha256 "17826f41cec8136c525773ee5eee89b4e5cae7b231458632a750f8f7cb39762e"
  license "MIT"

  depends_on "gh"
  depends_on "jq"

  def install
    bin.install "script.sh" => "github-helpers"
  end

  test do
    system bin/"github-helpers", "--help"
  end
end
