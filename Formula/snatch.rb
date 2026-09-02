class Snatch < Formula
  desc "Universal video downloader - yt-dlp + CDP browser fallback"
  homepage "https://github.com/maxgfr/snatch"
  url "https://github.com/maxgfr/snatch/archive/refs/tags/v1.6.0.tar.gz"
  version "v1.6.0"
  sha256 "0926c5882a32e6dfca54d8ca77e518572a9e705bc87f710e75896cae18292434"
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
