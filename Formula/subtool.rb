class Subtool < Formula
  desc "All-in-one CLI for subtitle management: download, translate, convert, sync, clean, merge, fix"
  homepage "https://github.com/maxgfr/subtool"
  url "https://github.com/maxgfr/subtool/archive/refs/tags/v1.4.0.tar.gz"
  version "v1.4.0"
  sha256 "a6c8cbcf53ef624f411a505c64d19349e9efec64d3fb5a8d857568c5f33d8f4a"
  license "MIT"

  depends_on "jq"
  depends_on "ffmpeg" => :recommended

  def install
    bin.install "subtool.sh" => "subtool"
  end

  test do
    system "#{bin}/subtool", "--version"
  end
end
