class Rshc < Formula
  desc "Rust reimplementation of SHC — encrypts shell scripts into compiled binaries"
  homepage "https://github.com/maxgfr/rshc"
  version "v1.3.4"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/rshc/releases/download/v1.3.4/rshc-macos-arm64"
      sha256 "7122a601392db2c9c6307b56a0edb9937db77562e68473f024c0cc0d379bb195"
    end

    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.3.4/rshc-macos-x64"
      sha256 "4de5fa560bb78837150222b6917eb7e8b2a9786865ef5072a2c2be2abb6720ac"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.3.4/rshc-linux-x64"
      sha256 "67197b11ea8b8e2db21da064b49c5287d2057f17a13696f6f02508027c132589"
    end
  end

  resource "rshc-runner" do
    on_macos do
      on_arm do
        url "https://github.com/maxgfr/rshc/releases/download/v1.3.4/rshc-runner-macos-arm64"
        sha256 "8b40671883d03879b53eba76a07a41fcfcb574a5e5c121e6995cacfbe6877d4f"
      end

      on_intel do
        url "https://github.com/maxgfr/rshc/releases/download/v1.3.4/rshc-runner-macos-x64"
        sha256 "74bd462c52e3308cf6e8e892681d3b8ddc22041ce46430be1efbb22f6c0a3e6d"
      end
    end

    on_linux do
      on_intel do
        url "https://github.com/maxgfr/rshc/releases/download/v1.3.4/rshc-runner-linux-x64"
        sha256 "b5c6c434638e7dd5e6ad749dc6f67d36b95c23b9fd849c6728f7d286145f3b75"
      end
    end
  end

  def install
    binary = Dir["rshc-*"].reject { |f| f.include?("runner") }.first

    if binary.nil?
      opoo "No rshc binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "rshc"

    resource("rshc-runner").stage do
      runner = Dir["rshc-runner-*"].first
      if runner
        chmod 0755, runner
        bin.install runner => "rshc-runner"
      end
    end
  end

  test do
    assert_match "rshc", shell_output("#{bin}/rshc --help 2>&1")
  end
end
