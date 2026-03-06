class Subtool < Formula
  desc "All-in-one CLI for subtitle management: download, translate, convert, sync, clean, merge, fix"
  homepage "https://github.com/maxgfr/subtool"
  url "https://github.com/maxgfr/subtool/archive/refs/tags/v1.2.1.tar.gz"
  version "v1.2.1"
  sha256 "aecba0a9570a4b11ba7d26af04fbc0002779bcacb142c5d8ceaf3b98caf51722"
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
