class Andro < Formula
  desc "Run Android apps from the macOS CLI on a disposable native emulator"
  homepage "https://github.com/maxgfr/andro"
  version "v1.2.1"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/andro/releases/download/v1.2.1/andro-macos-arm64"
      sha256 "fda4034bfca55101d74b9548dbcb2da19a34aad2ecd42d939f119e19efc8e9af"
    end

    on_intel do
      url "https://github.com/maxgfr/andro/releases/download/v1.2.1/andro-macos-x64"
      sha256 "406d103b6d3047b306ccccfbaa2c749995f1d0916b78eb5b3885d1a8169e7dce"
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
