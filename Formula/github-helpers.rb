class GithubHelpers < Formula
  desc "GitHub maintenance toolkit: bulk unstar, org clone, and more"
  homepage "https://github.com/maxgfr/github-helpers"
  url "https://github.com/maxgfr/github-helpers/archive/refs/tags/v1.3.1.tar.gz"
  version "v1.3.1"
  sha256 "da8abd0d0d565ae80024a7dbd4e1440d3cf3ec6403da87937c8da61f60846a87"
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
