class BinanceHistorical < Formula
  desc "Download historical klines from Binance API"
  homepage "https://github.com/maxgfr/binance-historical"
  version "1.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/binance-historical/releases/download/v1.6.0/binance-historical-macos-arm64"
      sha256 "PLACEHOLDER_SHA256_MACOS_ARM64"
    end

    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v1.6.0/binance-historical-macos-x64"
      sha256 "PLACEHOLDER_SHA256_MACOS_X64"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v1.6.0/binance-historical-linux-x64"
      sha256 "PLACEHOLDER_SHA256_LINUX_X64"
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
