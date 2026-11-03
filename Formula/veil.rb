class Veil < Formula
  desc "Peer-to-peer, end-to-end encrypted file transfer and chat in Veil rooms"
  homepage "https://github.com/maxgfr/veil"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.3.4/veil-aarch64-apple-darwin"
      sha256 "1a877164c2e968cde34af3dfe414aa42f43a8a7aca6bbecc13283bfda2e4249f"
    end

    on_intel do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.3.4/veil-x86_64-apple-darwin"
      sha256 "a756a3dd6a48cd99ff3e79d993efec4405e45877542f73a6f92a52bde773475f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.3.4/veil-aarch64-unknown-linux-gnu"
      sha256 "bfbe117d5629dfe92d0ce62a8061cd54e77285a758fa1993423794c224038417"
    end

    on_intel do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.3.4/veil-x86_64-unknown-linux-gnu"
      sha256 "bf13ac13007017bf0d6a24637b3f291914f45a5cdf78290ac58f3be623ac8bc9"
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
