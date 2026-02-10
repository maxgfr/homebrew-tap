class BinanceHistorical < Formula
  desc "Download historical klines from Binance API"
  homepage "https://github.com/maxgfr/binance-historical"
  version "v1.6.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/binance-historical/releases/download/v1.6.5/binance-historical-macos-arm64"
      sha256 "61a45631c49b6093f3e5d3a3f472aa962af06491640b0e9b48976a85e59a41b5"
    end

    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v1.6.5/binance-historical-macos-x64"
      sha256 "ac3184845502a80fe0bf04918dae1ee103d4749323eefe23ced5475914b25b43"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v1.6.5/binance-historical-linux-x64"
      sha256 "df62db0e370989fe243ac47197e37bcbe7842a977ba7575f2fe25af5526318ca"
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
