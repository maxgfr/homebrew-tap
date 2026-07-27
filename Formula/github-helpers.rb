class GithubHelpers < Formula
  desc "GitHub maintenance toolkit: bulk unstar, org clone, and more"
  homepage "https://github.com/maxgfr/github-helpers"
  url "https://github.com/maxgfr/github-helpers/archive/refs/tags/v1.4.0.tar.gz"
  version "v1.4.0"
  sha256 "917a2db045f92109f60a53978305cc3f03f0142b5a885316d7afb5a5eda23d2e"
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
