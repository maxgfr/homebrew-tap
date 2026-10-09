class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v5.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.1.0/conforme-macos-arm64"
      sha256 "fb7ef0fdeb9941950135e6588ca92a59cea9f627a9da4713b894e454b88841ab"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.1.0/conforme-macos-x64"
      sha256 "fdaef220ebf3dbbe4ee273e5335eb1aeb57904aaba4aa901ac1a0880907838f2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.1.0/conforme-linux-arm64"
      sha256 "a709869281cd07a61b44faa78762f19b76258a3e9aac7cc7c9ad7ca0ae9a42a2"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.1.0/conforme-linux-x64"
      sha256 "0192803147ab1aa46ac7f2d13f4bc65911486e38cdbafe7d1ae65781f7af86f8"
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
