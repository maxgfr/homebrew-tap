class Andro < Formula
  desc "Run Android apps from the macOS CLI on a disposable native emulator"
  homepage "https://github.com/maxgfr/andro"
  version "v1.1.0"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/andro/releases/download/v1.1.0/andro-macos-arm64"
      sha256 "d0bcb54e96be6e7dc8728a87fc4458b9e319e854ce912657a15e35c1d600ea7a"
    end

    on_intel do
      url "https://github.com/maxgfr/andro/releases/download/v1.1.0/andro-macos-x64"
      sha256 "1f88d8894a93b7292a6e9ed6a7f2e3b2b25c93b28482b85bf5d288e537419dcc"
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
