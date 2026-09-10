class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v1.14.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.14.2/conforme-macos-arm64"
      sha256 "f9ff388ef4aa4ea0af4bdf138c2fc233cae0b7a83dd2bf7eba4471edc8ceb8d4"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.14.2/conforme-macos-x64"
      sha256 "e331e0cbd455ab1a9790247ce5467754bce61ec18b854dc7466670f015263257"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.14.2/conforme-linux-arm64"
      sha256 "3c3bda7ce9d6cc9b8847cefe2a8376902a6d1ce1b11e7891abf1e9b62c3104ae"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.14.2/conforme-linux-x64"
      sha256 "00e8a2e092d8754f36af141b9c05b73f7d5670eb94665cd2a24305e36daeb06e"
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
