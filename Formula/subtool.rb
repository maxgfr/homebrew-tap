class Subtool < Formula
  desc "CLI for downloading, translating, syncing, and fixing subtitles"
  homepage "https://github.com/maxgfr/subtool"
  url "https://github.com/maxgfr/subtool/archive/refs/tags/v1.19.10.tar.gz"
  version "v1.19.10"
  sha256 "660cfb1ff2c4471be9b2a4b4738ffdab67358e1245fcf614618f75a14c851347"
  license "MIT"

  depends_on "curl"
  depends_on "jq"
  depends_on "python3"
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
