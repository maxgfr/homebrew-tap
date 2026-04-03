class GithubHelpers < Formula
  desc "GitHub maintenance toolkit: bulk unstar, org clone, and more"
  homepage "https://github.com/maxgfr/github-helpers"
  url "https://github.com/maxgfr/github-helpers/archive/refs/tags/v1.3.3.tar.gz"
  version "v1.3.3"
  sha256 "1abe1ca4a3120438a85fa8feb3a559183fb09d93f5457da17f1e3146cb7d490c"
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
