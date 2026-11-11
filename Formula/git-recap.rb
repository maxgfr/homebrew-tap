class GitRecap < Formula
  desc "Generate monthly commit recaps with AI summaries and bullet points"
  homepage "https://github.com/maxgfr/git-recap"
  url "https://github.com/maxgfr/git-recap/archive/refs/tags/v2.0.3.tar.gz"
  sha256 "0c3ae7baf3a7c65008c5b1b6c02c3c89a91bd277ea88e17eaac1e719a0c17160"
  license "MIT"

  depends_on "gh"
  depends_on "git"

  def install
    bin.install "script.sh" => "git-recap"
  end

  test do
    system bin/"git-recap", "--version"
  end
end
