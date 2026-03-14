class Rshc < Formula
  desc "Rust reimplementation of SHC — encrypts shell scripts into compiled binaries"
  homepage "https://github.com/maxgfr/rshc"
  version "v1.4.0"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/rshc/releases/download/v1.4.0/rshc-macos-arm64"
      sha256 "d5068945f7ca02ff595b7f1eb2b05539b2e6022e6c1dda7ff2b28a66f3e15f1d"
    end

    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.4.0/rshc-macos-x64"
      sha256 "f04d1ad5e9a60a70e88fea90a0564137d23818521a6cf1b3f53213fa3589f2bb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.4.0/rshc-linux-x64"
      sha256 "5338dd10018d7497e179237a43e740f75fa1e09bf8dd9d664c06afbbcfe4e5a0"
    end
  end

  resource "rshc-runner" do
    on_macos do
      on_arm do
        url "https://github.com/maxgfr/rshc/releases/download/v1.4.0/rshc-runner-macos-arm64"
        sha256 "b3029679d546f1d8e8b0ff4e6abb6a3d9d1803faa5f745f20829ca8ab0bdb139"
      end

      on_intel do
        url "https://github.com/maxgfr/rshc/releases/download/v1.4.0/rshc-runner-macos-x64"
        sha256 "4ed390c2f16f360338d59083849b3cd08c21b69d1efcd6f9455aad318c3bd21f"
      end
    end

    on_linux do
      on_intel do
        url "https://github.com/maxgfr/rshc/releases/download/v1.4.0/rshc-runner-linux-x64"
        sha256 "55f99b89d6c61029bcd85c0c1a6afac65d85cc0ca898e7addb69baf14483b57d"
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
