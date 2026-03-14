class Rshc < Formula
  desc "Rust reimplementation of SHC — encrypts shell scripts into compiled binaries"
  homepage "https://github.com/maxgfr/rshc"
  version "v1.4.2"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/rshc/releases/download/v1.4.2/rshc-macos-arm64"
      sha256 "a66b1637dd67805db00d7f19929364270a52d54fccc742a39b940640acd5d3b8"
    end

    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.4.2/rshc-macos-x64"
      sha256 "c7154ed2c8f47e2232aa302554d3909d5fffabb4ab8ca763ed5e08f15282b34c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.4.2/rshc-linux-x64"
      sha256 "3705256b4902ed42311da6662141ac1f7d6f9c7592ed53da592fbadb7301cbbc"
    end
  end

  resource "rshc-runner" do
    on_macos do
      on_arm do
        url "https://github.com/maxgfr/rshc/releases/download/v1.4.2/rshc-runner-macos-arm64"
        sha256 "1a5adf7c0b607a199b6b2f389af607a3c3ebd4e14a9ff4d4d0b7b4d162a80a91"
      end

      on_intel do
        url "https://github.com/maxgfr/rshc/releases/download/v1.4.2/rshc-runner-macos-x64"
        sha256 "67da67a3165486d08038a81e315dd1305c4e1f329b2b381d9e809e0ff410696c"
      end
    end

    on_linux do
      on_intel do
        url "https://github.com/maxgfr/rshc/releases/download/v1.4.2/rshc-runner-linux-x64"
        sha256 "d36a964eb59cfd20a26241ce3e173db01b8de82077ac7e2fc71a87dd1e79e0fe"
      end
    end
  end

  def install
    binary = Dir["rshc-*"].reject { |f| f.include?("runner") }.first

    if binary.nil?
      opoo "No rshc binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "rshc"

    resource("rshc-runner").stage do
      runner = Dir["rshc-runner-*"].first
      if runner
        chmod 0755, runner
        bin.install runner => "rshc-runner"
      end
    end
  end

  test do
    assert_match "rshc", shell_output("#{bin}/rshc --help 2>&1")
  end
end
