class Subtool < Formula
  desc "CLI for downloading, translating, syncing, and fixing subtitles"
  homepage "https://github.com/maxgfr/subtool"
  url "https://github.com/maxgfr/subtool/archive/refs/tags/v1.12.0.tar.gz"
  version "v1.12.0"
  sha256 "dfbc68eb98aa1cb34b3a72ad30d17cef53401ff5e28b85efaf22c810455cf284"
  license "MIT"

  depends_on "curl"
  depends_on "jq"
  depends_on "translate-shell"
  depends_on "uv" => :recommended
  depends_on "ffmpeg" => :recommended

  def install
    bin.install "subtool.sh" => "subtool"
  end

  def caveats
    <<~EOS
      subtool works out of the box — no API keys needed.
      Subtitles are downloaded from OpenSubtitles.org and Podnapisi (free sources).
      Translation uses Google Translate via translate-shell (default, fast, free).
      Recommended dependencies installed by default:
        - uv for autosync via ffsubsync
        - ffmpeg for auto-embed, extract, and embed commands
      The `auto` command does everything: download + translate + sync + embed.
      Run `subtool check` to verify your setup.
    EOS
  end

  test do
    system bin/"subtool", "--version"
  end
end
