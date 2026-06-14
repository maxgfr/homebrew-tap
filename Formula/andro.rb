class Andro < Formula
  desc "Run Android apps from the macOS CLI on a disposable native emulator"
  homepage "https://github.com/maxgfr/andro"
  version "v1.2.0"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/andro/releases/download/v1.2.0/andro-macos-arm64"
      sha256 "2972ab900cc33da59431ad392c6a1b779c8a4e4e7803a57cece3a7033075a5d1"
    end

    on_intel do
      url "https://github.com/maxgfr/andro/releases/download/v1.2.0/andro-macos-x64"
      sha256 "a6328afd204b5853e80e8a82ff0d6cfd004566ec1c0f22a6e71d48a01726425c"
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
