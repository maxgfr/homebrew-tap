class Rshc < Formula
  desc "Rust reimplementation of SHC — encrypts shell scripts into compiled binaries"
  homepage "https://github.com/maxgfr/rshc"
  version "v1.3.0"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/rshc/releases/download/v1.3.0/rshc-macos-arm64"
      sha256 "aa58c9b95f04d296a416e796a6049f18d2d2f701a786f901689e66b75810702e"
    end

    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.3.0/rshc-macos-x64"
      sha256 "00642e1ab06f5ef6eac0c105b622a77e76962a59b68ac9cb30260bed949f5342"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.3.0/rshc-linux-x64"
      sha256 "faecb333de695abd2bffc07b8799679d6c678cfe818325722f34d3e10b21f9be"
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
