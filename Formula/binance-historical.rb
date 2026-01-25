class BinanceHistorical < Formula
  desc "Download historical klines from Binance API"
  homepage "https://github.com/maxgfr/binance-historical"
  version "v1.6.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/binance-historical/releases/download/v1.6.1/binance-historical-macos-arm64"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end

    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v1.6.1/binance-historical-macos-x64"
      sha256 "ac3184845502a80fe0bf04918dae1ee103d4749323eefe23ced5475914b25b43"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v1.6.1/binance-historical-linux-x64"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
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
