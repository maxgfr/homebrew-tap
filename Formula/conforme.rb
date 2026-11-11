class Conforme < Formula
  desc "Sync AI coding agent configuration from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.5/conforme-macos-arm64"
      sha256 "19d619e1dac9ee313f7dc72123d60e9ed9df21666389c62da4b9cac7d1778730"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.5/conforme-macos-x64"
      sha256 "1948038a8d87072b7ecb678fc667f07ba761ebc1041ecb5b109f2c557642d181"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.5/conforme-linux-arm64"
      sha256 "172d73fa719f7102b310ec47a88a31e0a8f18d9a6b5258c96cd82670ad3e906a"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.5/conforme-linux-x64"
      sha256 "526020c7a52ccf7bbdaeef0b08328535ba4a7ed03b83edb3c59c41b43639509c"
    end
  end

  def install
    binary = Dir["conforme-*"].first

    if binary.nil?
      opoo "No conforme binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "conforme"
  end

  test do
    assert_match "conforme", shell_output("#{bin}/conforme --help 2>&1")
  end
end
