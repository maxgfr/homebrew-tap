class Andro < Formula
  desc "Run Android apps from the macOS CLI on a disposable native emulator"
  homepage "https://github.com/maxgfr/andro"
  version "v1.0.0"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/andro/releases/download/v1.0.0/andro-macos-arm64"
      sha256 "e446b83393371cfd209d446cd5b21e836090463ce0475fd91ffae5456a8cdc83"
    end

    on_intel do
      url "https://github.com/maxgfr/andro/releases/download/v1.0.0/andro-macos-x64"
      sha256 "a9bd9be5d1d126c50c4791e5a0a8fb36037fd8fd585eeff17481748565392ad9"
    end
  end

  def install
    binary = Dir["andro-*"].first

    if binary.nil?
      opoo "No andro binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "andro"
  end

  test do
    assert_match "andro", shell_output("#{bin}/andro --help 2>&1")
  end
end
