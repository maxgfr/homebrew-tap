class Snatch < Formula
  desc "Universal video downloader - yt-dlp + CDP browser fallback"
  homepage "https://github.com/maxgfr/snatch"
  url "https://github.com/maxgfr/snatch/archive/refs/tags/v1.5.1.tar.gz"
  version "v1.5.1"
  sha256 "a7a33df067c8a9e273583af185378bb21a999cfc9e7b294ee97309c115b20a94"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "node"
  depends_on "yt-dlp"

  def install
    bin.install "download.sh" => "snatch"
    libexec.install "extract_video_url.mjs", "package.json", "package-lock.json"
    system "npm", "ci", "--prefix", libexec, "--omit=dev"
    inreplace bin/"snatch",
              'SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"',
              "SCRIPT_DIR=\"#{libexec}\""
  end

  def caveats
    <<~EOS
      snatch's CDP fallback requires a Chromium-based browser at runtime.
      Install one of:
        brew install --cask google-chrome
        brew install --cask brave-browser
        brew install --cask microsoft-edge
        brew install --cask chromium
      Or override autodetection with:
        export SNATCH_CHROME=/path/to/browser

      Optional env vars:
        SNATCH_COOKIES=/path/to/cookies.txt   Netscape-format cookies
        SNATCH_VERBOSE=1                      Debug output
        EXTRACT_TIMEOUT=30000                 CDP timeout (ms)
    EOS
  end

  test do
    assert_match version.to_s.delete_prefix("v"), shell_output("#{bin}/snatch --version")
    assert_match "Universal video downloader", shell_output("#{bin}/snatch --help")
  end
end
