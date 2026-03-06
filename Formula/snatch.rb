class Snatch < Formula
  desc "Universal video downloader - yt-dlp + CDP browser fallback"
  homepage "https://github.com/maxgfr/snatch"
  url "https://github.com/maxgfr/snatch/archive/refs/tags/v1.2.0.tar.gz"
  version "v1.2.0"
  sha256 "f3f841cdf4c06df2e658cc3ec944f857cfdf2b376b2d42ea69e5a009a75f3056"
  license "MIT"

  depends_on "yt-dlp"
  depends_on "ffmpeg"
  depends_on "node"

  def install
    bin.install "download.sh" => "snatch"
    libexec.install "extract_video_url.mjs"
    libexec.install "package.json"
    system "npm", "install", "--prefix", libexec
    inreplace bin/"snatch", 'SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"', "SCRIPT_DIR=\"#{libexec}\""
  end

  test do
    assert_match "snatch", shell_output("#{bin}/snatch --version")
  end
end
