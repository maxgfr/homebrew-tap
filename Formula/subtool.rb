class Subtool < Formula
  desc "CLI for downloading, translating, syncing, and fixing subtitles"
  homepage "https://github.com/maxgfr/subtool"
  url "https://github.com/maxgfr/subtool/archive/refs/tags/v1.4.0.tar.gz"
  version "1.4.0"
  sha256 "a6c8cbcf53ef624f411a505c64d19349e9efec64d3fb5a8d857568c5f33d8f4a"
  license "MIT"

  depends_on "curl"
  depends_on "jq"
  depends_on "uv" => :recommended
  depends_on "ffmpeg" => :recommended

  def install
    bin.install "subtool.sh" => "subtool"
  end

  def caveats
    <<~EOS
      subtool works out of the box — no API keys needed.
      Subtitles are downloaded from OpenSubtitles.org and Podnapisi (free sources).
      Recommended dependencies installed by default:
        - uv for autosync via `uvx ffsubsync`
        - ffmpeg for extract and embed commands
      If you install with `--skip-recommended`, autosync/extract/embed require manual setup.
      Run `subtool check` to verify your setup.
    EOS
  end

  test do
    system bin/"subtool", "--version"
  end
end
