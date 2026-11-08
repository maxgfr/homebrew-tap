class GithubHelpers < Formula
  desc "Bulk-unstar repos, clone whole orgs and run other GitHub maintenance tasks"
  homepage "https://github.com/maxgfr/github-helpers"
  url "https://github.com/maxgfr/github-helpers/archive/refs/tags/v1.8.0.tar.gz"
  sha256 "684c4bbfa219a92f58e4be4f00b38fb9e0f15aee36062e68ac8bc1103b9502b0"
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
