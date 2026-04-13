class Conforme < Formula
  desc "Universal AI coding agent config synchronization — syncs AGENTS.md to all tools"
  homepage "https://github.com/maxgfr/conforme"
  version "v0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v0.1.0/conforme-macos-arm64"
      sha256 "PLACEHOLDER"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v0.1.0/conforme-macos-x64"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v0.1.0/conforme-linux-x64"
      sha256 "PLACEHOLDER"
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
