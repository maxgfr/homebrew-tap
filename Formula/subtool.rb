class Subtool < Formula
  desc "CLI for downloading, translating, syncing, and fixing subtitles"
  homepage "https://github.com/maxgfr/subtool"
  url "https://github.com/maxgfr/subtool/archive/refs/tags/v1.20.0.tar.gz"
  version "v1.20.0"
  sha256 "f6cbaa45803a2fe6077ddb2ca3469e35daceab00cf340aa0cc2e2b0fc25d2471"
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
