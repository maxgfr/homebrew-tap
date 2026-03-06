class Subtool < Formula
  desc "All-in-one CLI for subtitle management: download, translate, convert, sync, clean, merge, fix"
  homepage "https://github.com/maxgfr/subtool"
  url "https://github.com/maxgfr/subtool/archive/refs/tags/v1.0.0.tar.gz"
  version "v1.0.0"
  sha256 ""
  license "MIT"

  depends_on "jq"
  depends_on "python3"
  depends_on "ffmpeg" => :recommended

  def install
    bin.install "subtool.sh" => "subtool"
  end

  test do
    system "#{bin}/subtool", "--version"
  end
end
