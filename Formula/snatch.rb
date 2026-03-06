class Snatch < Formula
  desc "Universal video downloader - yt-dlp + CDP browser fallback"
  homepage "https://github.com/maxgfr/snatch"
  url "https://github.com/maxgfr/snatch/archive/refs/tags/v1.1.0.tar.gz"
  version "v1.1.0"
  sha256 "25308d6af7a0a791063310abe5bce2a00ccf5109fcf55011dbf36c805d8cf6cc"
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
