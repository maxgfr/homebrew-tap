class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v3.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v3.0.0/conforme-macos-arm64"
      sha256 "3f4d4d24149f9682b898bdd0cc3a53a8d7721b91126c2fbb6883a66adeec2204"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v3.0.0/conforme-macos-x64"
      sha256 "003f65902bee78350ce3696472d6487256e34ce018d4a3804c54ea09b198389c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v3.0.0/conforme-linux-arm64"
      sha256 "6efba0d6fcf1f3cfe945a4c711b620e2a81c361c003f23e8b2fa13a7035f849a"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v3.0.0/conforme-linux-x64"
      sha256 "6ba658861f0b32d2c51078a42d8841f37b4b30d845e43c079eb561f952e9da19"
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
