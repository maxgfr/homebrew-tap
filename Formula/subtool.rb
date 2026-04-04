class Subtool < Formula
  desc "CLI for downloading, translating, syncing, and fixing subtitles"
  homepage "https://github.com/maxgfr/subtool"
  url "https://github.com/maxgfr/subtool/archive/refs/tags/v1.19.4.tar.gz"
  version "v1.19.4"
  sha256 "a9a196076ee7d778bfb6d1cbe862d18ecc5d8c46c05dfdb042c417312943ff35"
  license "MIT"

  depends_on "curl"
  depends_on "jq"
  depends_on "translate-shell"
  depends_on "uv" => :recommended
  depends_on "ffmpeg" => :recommended

  def install
    bin.install "subtool.sh" => "subtool"
  end

  test do
    system bin/"subtool", "--version"
  end
end
