class Veil < Formula
  desc "Peer-to-peer, end-to-end encrypted file transfer and chat in Veil rooms"
  homepage "https://github.com/maxgfr/veil"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.3.0/veil-aarch64-apple-darwin"
      sha256 "e1103219e3bd978262d7ab5e1256bab30c35ef9ae3b9ee76c005a87a36965e7d"
    end

    on_intel do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.3.0/veil-x86_64-apple-darwin"
      sha256 "8e05be7b73df58861efb78f1c6fba2edbe06c43e7e05d5bcb6a0ec7d0185fc92"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.3.0/veil-aarch64-unknown-linux-gnu"
      sha256 "edfc8adba777af7a95781b69c8c2a78e47f9b3f85d099aa914ab612e250a2932"
    end

    on_intel do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.3.0/veil-x86_64-unknown-linux-gnu"
      sha256 "a73d370c4c419e5684e59caa8b4e7a99463880b47d1884ff7ada4c5a6cc86465"
    end
  end

  def install
    binary = Dir["veil-*"].first

    if binary.nil?
      opoo "No veil binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "veil"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/veil --version")
    # A fresh room link, generated offline: the same format the web app opens.
    assert_match %r{^https://maxgfr\.github\.io/veil/#[A-Za-z0-9_-]{43}$}, shell_output("#{bin}/veil new").strip
  end
end
