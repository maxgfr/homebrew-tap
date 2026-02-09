class RatioMaster < Formula
  desc "Educational BitTorrent ratio simulator - understand upload ratios on torrent trackers"
  homepage "https://github.com/maxgfr/ratio-master"
  url "https://github.com/maxgfr/ratio-master/archive/refs/tags/v1.1.1.tar.gz"
  version "v1.1.1"
  sha256 "c3b296b6655fffd56e8cc63fec09dffb7e9a0905b5967cd9abb43e4bdad00edf"
  license "MIT"

  def install
    bin.install "ratio-master.sh" => "ratio-master"
  end

  test do
    system "#{bin}/ratio-master", "--version"
  end
end
