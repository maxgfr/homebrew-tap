class BinanceHistorical < Formula
  desc "Download historical klines from Binance API"
  homepage "https://github.com/maxgfr/binance-historical"
  version "1.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/binance-historical/releases/download/v1.6.0/binance-historical-macos-arm64"
      sha256 "9aae975cbdde944cb7a0db5c67160381b38766c89d7a6ab147767c54f54eef3d"
    end

    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v1.6.0/binance-historical-macos-x64"
      sha256 "ac3184845502a80fe0bf04918dae1ee103d4749323eefe23ced5475914b25b43"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v1.6.0/binance-historical-linux-x64"
      sha256 "589c021da6520bce1c8951f7ddfc386b7e2898b88197ebbae67856e8292c6529"
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
