class Conforme < Formula
  desc "Sync AI coding agent configuration from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.9.1/conforme-macos-arm64"
      sha256 "1a934ba3881bbbbf5784aba956443610b60eaface9cbf246a81597afc374163e"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.9.1/conforme-macos-x64"
      sha256 "421d0db07f46167b014c283fc5bd597263d0b7656d3523bb8e27379895e10c8f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.9.1/conforme-linux-arm64"
      sha256 "39bdb670e8d99cb4d778b4dcfc211dcd60de30923be6531ae8beaeff77e407a7"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.9.1/conforme-linux-x64"
      sha256 "0cf2eb57cb0c05f3bfab6d694bd4330c52d25722f1e7d7bdbae64775b0c44af5"
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
