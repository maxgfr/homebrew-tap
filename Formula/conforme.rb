class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v1.10.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.10.0/conforme-macos-arm64"
      sha256 "93034f6ecdee1edabb5799f6a45027d7e267ee405b8be66809d18e589be83411"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.10.0/conforme-macos-x64"
      sha256 "86a26cf7de7a4a26709f96f5674dd5b6264b191b89f3e2449aad4981df4dfcde"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.10.0/conforme-linux-arm64"
      sha256 "935cf7015ebab81a59dd6d8fdd41cea5c58475d64e9d91c9836f3867cc40e636"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.10.0/conforme-linux-x64"
      sha256 "415084937db3ecef00b71c4ad5a4ef615dc224c7b07f54ed21ebc64ee5afcca6"
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
