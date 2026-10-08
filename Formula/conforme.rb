class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v4.0.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v4.0.2/conforme-macos-arm64"
      sha256 "b79867b519424e1eb205e025e25ed295ad06969ec2b425e8d2aafce4371e111f"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v4.0.2/conforme-macos-x64"
      sha256 "30d8ef1b8ed13a940389c9a2e777bef3fbfab1dba947d36f43afac78c270b9c0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v4.0.2/conforme-linux-arm64"
      sha256 "32a91e7a24a6f297fc8c7b7f0fd188196afb471eddbd25d099035af132edf002"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v4.0.2/conforme-linux-x64"
      sha256 "73a70ccb0d1161812873ec416b75ad1fa6da0e5337f42ae7565ff4a4f52ae774"
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
