class BinanceHistorical < Formula
  desc "Download historical klines from Binance API"
  homepage "https://github.com/maxgfr/binance-historical"
  version "v2.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/binance-historical/releases/download/v2.1.0/binance-historical-macos-arm64"
      sha256 "0c5d3515be0a6ac79a14ea34dd764fa6bddae834825e7a4fb6b7d6755f78a166"
    end

    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v2.1.0/binance-historical-macos-x64"
      sha256 "ac3184845502a80fe0bf04918dae1ee103d4749323eefe23ced5475914b25b43"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v2.1.0/binance-historical-linux-x64"
      sha256 "82c73ac3b8389774e4cc954698b3d8f0c76afcd14262520836ab9d152e6dcb3f"
    end
  end

  def install
    # Determine which binary was downloaded based on the filename
    binary = Dir["binance-historical-*"].first

    if binary.nil?
      opoo "No binance-historical binary found"
      return
    end

    # Make it executable
    chmod 0755, binary

    # Install to bin with consistent name
    bin.install binary => "binance-historical"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/binance-historical --version")
  end
end
