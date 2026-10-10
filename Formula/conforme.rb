class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v5.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.2.0/conforme-macos-arm64"
      sha256 "0050af10c264aefc00bf4ae2a5c854eee124d0b9329b35bdc4cc82e14ec61a14"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.2.0/conforme-macos-x64"
      sha256 "e27229198e4e5af95448c1ada7c3ab70ebd8cb39b5f1a7c16f558a155d41fe5f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.2.0/conforme-linux-arm64"
      sha256 "7563c4ef2b9ae18c5321f9c6d7edd1b146d362606df323ae7e774b3b848ea3b8"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.2.0/conforme-linux-x64"
      sha256 "a35696ce5cf11fa5c9c0d0c5e1cd607ab6587ae41771757c0ffd61932035e917"
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
