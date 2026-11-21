class GithubHelpers < Formula
  desc "Bulk-unstar repos, clone whole orgs and run other GitHub maintenance tasks"
  homepage "https://github.com/maxgfr/github-helpers"
  url "https://github.com/maxgfr/github-helpers/archive/refs/tags/v1.10.2.tar.gz"
  sha256 "365fc286cc9d7d73a2a4a8eb86d5721e033c8b9e45aedd5755597e17ab8ec9ea"
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
