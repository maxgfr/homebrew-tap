class Codexify < Formula
  desc "Codex toolbelt for profiles, notifications, backup, and keep-awake"
  homepage "https://github.com/maxgfr/codexify"
  license "MIT"

  depends_on "maxgfr/tap/conforme"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.0/codexify-macos-arm64"
      sha256 "9d3b84436b150a807cc77cb3f73331ccf88e332ef32bd549f6481de07c5a9d97"
    end

    on_intel do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.0/codexify-macos-x64"
      sha256 "22c47b7a772e692cfa00d2196af8eed399fe4e084828ef284278beaae03eede3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.0/codexify-linux-arm64"
      sha256 "40a018dc1984144bcbb8fdff3aaaff2965d4b5507d7304967fe7ea7fb1f28574"
    end

    on_intel do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.0/codexify-linux-x64"
      sha256 "f03df8e622d72c572c6513e676647a710d8d51840a5d9b1c5519176f20d6778c"
    end
  end

  def install
    binary = Dir["codexify-*"].first

    if binary.nil?
      opoo "No codexify binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "codexify"
  end

  test do
    assert_match "codexify 0.1.0", shell_output("#{bin}/codexify --version")
  end
end
