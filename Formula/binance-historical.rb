class BinanceHistorical < Formula
  desc "Download historical klines from Binance API"
  homepage "https://github.com/maxgfr/binance-historical"
  version "v1.6.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/binance-historical/releases/download/v1.6.3/binance-historical-macos-arm64"
      sha256 "61a9ca0441fd6014a1c3f02d7c88f2c9c026b59219c793c8d7b09ddc01756961"
    end

    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v1.6.3/binance-historical-macos-x64"
      sha256 "ac3184845502a80fe0bf04918dae1ee103d4749323eefe23ced5475914b25b43"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v1.6.3/binance-historical-linux-x64"
      sha256 "f559277de8b928e50ff69a1c4b30cdae6f3df6ee771b331b65b77d3c408b1b35"
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
