class Rshc < Formula
  desc "Rust reimplementation of SHC — encrypts shell scripts into compiled binaries"
  homepage "https://github.com/maxgfr/rshc"
  version "v1.0.0"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/rshc/releases/download/v1.0.0/rshc-macos-arm64"
      sha256 "d7e0bc77481240d3b43c160db2ed5811ed8ec83a03d5056437ba4ab5f177a480"
    end

    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.0.0/rshc-macos-x64"
      sha256 "00642e1ab06f5ef6eac0c105b622a77e76962a59b68ac9cb30260bed949f5342"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.0.0/rshc-linux-x64"
      sha256 "18d67e6dc9c517873965d4ce5d7758755d5526740a2436309882f5f45b4f2b5b"
    end
  end

  def install
    binary = Dir["rshc-*"].first

    if binary.nil?
      opoo "No rshc binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "rshc"
  end

  test do
    assert_match "rshc", shell_output("#{bin}/rshc --help 2>&1")
  end
end
