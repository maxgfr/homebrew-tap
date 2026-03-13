class Rshc < Formula
  desc "Rust reimplementation of SHC — encrypts shell scripts into compiled binaries"
  homepage "https://github.com/maxgfr/rshc"
  version "v1.1.0"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/rshc/releases/download/v1.1.0/rshc-macos-arm64"
      sha256 "35d03ef72f530b7d1d03778ec547f14ec77861d2479c51fd7adf67bb5f97f7c7"
    end

    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.1.0/rshc-macos-x64"
      sha256 "00642e1ab06f5ef6eac0c105b622a77e76962a59b68ac9cb30260bed949f5342"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.1.0/rshc-linux-x64"
      sha256 "91e5510c378551fc8f38194fc10af7962cc5924ae3d3186a7330c21bad950454"
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
