class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v1.9.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.9.1/conforme-macos-arm64"
      sha256 "8582d17de9f4c39a35358149c9dd94e02351b029fa671615196f328a53902b54"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.9.1/conforme-macos-x64"
      sha256 "0467b0aabd064f302cd45393609d7308ba143bf63ab9c7fcc4c9a61d236974b7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.9.1/conforme-linux-arm64"
      sha256 "fc2c03e4ce577c25dbee091d4969f493062402271caf2c9cbfc6d05c19076cb5"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.9.1/conforme-linux-x64"
      sha256 "f5cdee3f3a11947f1648e0fc7cde0efa314ecc2dffbd81ece29ef8e0d80def93"
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
