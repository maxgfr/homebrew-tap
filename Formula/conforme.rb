class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v1.8.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.8.3/conforme-macos-arm64"
      sha256 "08735c1e14a9317937af254d32a70580babecf6252e0b55c2c3112a45404200e"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.8.3/conforme-macos-x64"
      sha256 "f9c853b45eb901f437f4e318b2e3d8ea5ec98b6ba8148ff66793e7b98a899cac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.8.3/conforme-linux-arm64"
      sha256 "b26d197cd0b953ac9d822953486c05e5a6b10ad8c590f9a4e1b462b76b293be4"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.8.3/conforme-linux-x64"
      sha256 "5f6b4a5952b03a643b7754bdc7e0fcf70de725ce53e6d25727e07a73c56decd9"
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
