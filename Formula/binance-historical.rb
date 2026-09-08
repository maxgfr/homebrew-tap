class BinanceHistorical < Formula
  desc "Download historical klines from Binance API"
  homepage "https://github.com/maxgfr/binance-historical"
  version "v2.0.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/binance-historical/releases/download/v2.0.3/binance-historical-macos-arm64"
      sha256 "36ef2dc6adc34fae0ab19f60ea330c0f061bf781a956110110918684ae537df6"
    end

    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v2.0.3/binance-historical-macos-x64"
      sha256 "ac3184845502a80fe0bf04918dae1ee103d4749323eefe23ced5475914b25b43"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/binance-historical/releases/download/v2.0.3/binance-historical-linux-x64"
      sha256 "9c4743dc0a22d965d2f4057b0fff6635fb93bb0e8cb6ddb52b6612cae6d89698"
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
