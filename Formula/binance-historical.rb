class BinanceHistorical < Formula
  desc "Download historical klines from Binance API"
  homepage "https://github.com/maxgfr/binance-historical"
  version "v2.0.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/binance-historical/releases/download/v2.0.4/binance-historical-macos-arm64"
      sha256 "b7ba9094067075ae7fe65c37cbf10c5b7aaed538a7504f6dbafd6bfb264eedf3"
    end

    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v2.0.4/binance-historical-macos-x64"
      sha256 "ac3184845502a80fe0bf04918dae1ee103d4749323eefe23ced5475914b25b43"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v2.0.4/binance-historical-linux-x64"
      sha256 "e9f0520a7eb91a8d15d46ad1ae9295aa6dbd1d8ff7c94d01060fc96a5a4611cb"
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
