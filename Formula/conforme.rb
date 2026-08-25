class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v1.14.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.14.0/conforme-macos-arm64"
      sha256 "352e95cabccd946f5eaead33e45de38f396cc2f4e1b7577690ba678ee1234124"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.14.0/conforme-macos-x64"
      sha256 "cb8447030662dbcda36058d7cbef2a75495558b2189a4d91dd8d4cb3e843f21b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.14.0/conforme-linux-arm64"
      sha256 "264edd2d4b573462cb220e48d60bdcaca97e297d8ffdb974a17e1cded2a583a6"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.14.0/conforme-linux-x64"
      sha256 "9d3fa1278a86a30d87615b7a0beb5fadd586c163121ce46048be4989cfe0e892"
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
