class RatioMaster < Formula
  desc "Educational BitTorrent ratio simulator - understand upload ratios on torrent trackers"
  homepage "https://github.com/maxgfr/ratio-master"
  url "https://github.com/maxgfr/ratio-master/archive/refs/tags/v1.0.3.tar.gz"
  version "v1.0.3"
  sha256 "69f16c65bc24feaf08138e606cdf15e183eacec7325e14155755e7f6b77c588b"
  license "MIT"

  def install
    bin.install "ratio-master.sh" => "ratio-master"
  end

  test do
    system "#{bin}/ratio-master", "--version"
  end
end
