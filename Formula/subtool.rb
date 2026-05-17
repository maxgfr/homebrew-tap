class Subtool < Formula
  desc "CLI for downloading, translating, syncing, and fixing subtitles"
  homepage "https://github.com/maxgfr/subtool"
  url "https://github.com/maxgfr/subtool/archive/refs/tags/v1.20.2.tar.gz"
  version "v1.20.2"
  sha256 "3a2f0c82043d470a053dce3bdfc3a5c88f5fa3878260e3f6484de28a85106aa8"
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
