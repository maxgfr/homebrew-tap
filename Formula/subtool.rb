class Subtool < Formula
  desc "CLI for downloading, translating, syncing, and fixing subtitles"
  homepage "https://github.com/maxgfr/subtool"
  url "https://github.com/maxgfr/subtool/archive/refs/tags/v1.19.7.tar.gz"
  version "v1.19.7"
  sha256 "65b2d7c4462d58355a5309025c665e94470d4f4b8abf5a1a0ac07fabab1cb5bc"
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
