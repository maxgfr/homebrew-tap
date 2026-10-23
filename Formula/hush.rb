class Hush < Formula
  desc "Post-quantum, end-to-end encrypted chat and file transfer"
  homepage "https://github.com/maxgfr/hush"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/hush/releases/download/cli-v3.1.1/hush-aarch64-apple-darwin"
      sha256 "f429efb38e4bba18700d17254f9b793ccc6addf906637efb6306a4116d08b6a6"
    end

    on_intel do
      url "https://github.com/maxgfr/hush/releases/download/cli-v3.1.1/hush-x86_64-apple-darwin"
      sha256 "8ae1f58c4d2a7a21693589f8be2a1ecd43233926b9abe3b50814cf4a5412eb02"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/hush/releases/download/cli-v3.1.1/hush-aarch64-unknown-linux-gnu"
      sha256 "7f1a1c190610cdf5fb4b78486fc7c25786093ace5f86045e0d9b518ba9714f7f"
    end

    on_intel do
      url "https://github.com/maxgfr/hush/releases/download/cli-v3.1.1/hush-x86_64-unknown-linux-gnu"
      sha256 "e490cd23105edcf6585e13e0a7b16f6cd286cf35cc0fd4d17434649517aa9865"
    end
  end

  def install
    binary = Dir["hush-*"].first

    if binary.nil?
      opoo "No hush binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "hush"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hush --version")
    # A fresh link, generated offline: the same format the web app opens.
    link = shell_output("#{bin}/hush new").strip
    assert_match %r{^https://maxgfr\.github\.io/hush/#[1-9]\.s\.[A-Za-z0-9_-]{43}\.[0-9a-z]+$}, link
  end
end
