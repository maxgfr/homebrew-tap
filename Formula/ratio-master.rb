class RatioMaster < Formula
  desc "Torrent ratio tool sending real HTTP announce requests to BitTorrent trackers"
  homepage "https://github.com/maxgfr/ratio-master"
  url "https://github.com/maxgfr/ratio-master/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "92798606ac31010220c4e7ab37203b9db4a66099b0d2e80301aacfdf8bddc42a"
  license "MIT"

  def install
    bin.install "ratio-master.sh" => "ratio-master"
  end

  test do
    system bin/"ratio-master", "--version"
  end
end
