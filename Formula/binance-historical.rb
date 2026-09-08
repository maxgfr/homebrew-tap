class BinanceHistorical < Formula
  desc "Download historical klines from Binance API"
  homepage "https://github.com/maxgfr/binance-historical"
  version "v2.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/binance-historical/releases/download/v2.0.1/binance-historical-macos-arm64"
      sha256 "128d66b487681893c1528387e23908cdfa840d64c597b823a2ed267f017e1284"
    end

    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v2.0.1/binance-historical-macos-x64"
      sha256 "ac3184845502a80fe0bf04918dae1ee103d4749323eefe23ced5475914b25b43"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v2.0.1/binance-historical-linux-x64"
      sha256 "d096443a5c7434ef3197e2eafc785b0315a37ec2c22c33d9f73c59d8a8b8afed"
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
