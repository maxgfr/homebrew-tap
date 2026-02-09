class RatioMaster < Formula
  desc "Educational BitTorrent ratio simulator - understand upload ratios on torrent trackers"
  homepage "https://github.com/maxgfr/ratio-master"
  url "https://github.com/maxgfr/ratio-master/archive/refs/tags/v1.2.0.tar.gz"
  version "v1.2.0"
  sha256 "a8011da23207175878a5434760d57b159bf65581c1e8734cc59d1dfd0f33132c"
  license "MIT"

  def install
    bin.install "ratio-master.sh" => "ratio-master"
  end

  test do
    system "#{bin}/ratio-master", "--version"
  end
end
