class RatioMaster < Formula
  desc "Educational BitTorrent ratio simulator - understand upload ratios on torrent trackers"
  homepage "https://github.com/maxgfr/ratio-master"
  url "https://github.com/maxgfr/ratio-master/archive/refs/tags/v1.0.0.tar.gz"
  version "v1.0.0"
  sha256 ""
  license "MIT"

  def install
    bin.install "ratio-master.sh" => "ratio-master"
  end

  test do
    system "#{bin}/ratio-master", "--version"
  end
end
