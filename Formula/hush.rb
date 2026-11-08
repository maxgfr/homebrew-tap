class Hush < Formula
  desc "Chat and transfer files with post-quantum end-to-end encryption"
  homepage "https://github.com/maxgfr/hush"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/hush/releases/download/cli-v3.3.1/hush-aarch64-apple-darwin"
      sha256 "d55fa630a54e83abffeabcd486f26aeb2eb5edda0fff461cc22e7ae3d9e19e0a"
    end

    on_intel do
      url "https://github.com/maxgfr/hush/releases/download/cli-v3.3.1/hush-x86_64-apple-darwin"
      sha256 "9028e8ef9d21901cf4f6652b17d9cd9b9fac860a09f8824d67549309baf047b7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/hush/releases/download/cli-v3.3.1/hush-aarch64-unknown-linux-gnu"
      sha256 "2e3c62b43e5d221ebf8a0aae3dcb9abc1f76561d0632f5bfa4a66811f2a193b0"
    end

    on_intel do
      url "https://github.com/maxgfr/hush/releases/download/cli-v3.3.1/hush-x86_64-unknown-linux-gnu"
      sha256 "ac6062e3dd89762cf3a7a6fe1d6939a10389d29fd12dd8efc7f9c0d5e7cd5c64"
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
