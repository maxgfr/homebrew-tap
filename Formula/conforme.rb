class Conforme < Formula
  desc "Universal AI coding agent config synchronization — syncs AGENTS.md to all tools"
  homepage "https://github.com/maxgfr/conforme"
  version "v1.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.6.0/conforme-macos-arm64"
      sha256 "e5c0e3999030cd53399fdfba8877d3694a28151386f14a66c2287269ca314b26"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.6.0/conforme-macos-x64"
      sha256 "f32b38db58552bc3e44a036814484f35c81bd69578628cd3bf75a466476f2f6f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v0.1.0/conforme-linux-arm64"
      sha256 "PLACEHOLDER"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.6.0/conforme-linux-x64"
      sha256 "c4db98de7ffdcfa590fa422f7892d9efb48d533ddeb8e0e37f5b522daf58a785"
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
