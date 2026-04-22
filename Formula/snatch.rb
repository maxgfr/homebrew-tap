class Snatch < Formula
  desc "Universal video downloader - yt-dlp + CDP browser fallback"
  homepage "https://github.com/maxgfr/snatch"
  url "https://github.com/maxgfr/snatch/archive/refs/tags/v1.3.2.tar.gz"
  version "v1.3.2"
  sha256 "c34dcd057bc0381bb8b07e82b55cbe592ce9ae58e77b38b30fa3264096b006ed"
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
