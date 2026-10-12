class Veil < Formula
  desc "Peer-to-peer, end-to-end encrypted file transfer and chat in Veil rooms"
  homepage "https://github.com/maxgfr/veil"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.1.0/veil-aarch64-apple-darwin"
      sha256 "c88894df6c65c1fcfea49594fbd093acc71230c3181827a5e95851fc0613f254"
    end

    on_intel do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.1.0/veil-x86_64-apple-darwin"
      sha256 "950993f3963539a35a3bfc2462d2623a45b27adfac0a38aa668d36cf0255100f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.1.0/veil-aarch64-unknown-linux-gnu"
      sha256 "b8a7a84ced15923d27863d7ff16808ca45d1b9a64e5008d00c66f878a6441ee0"
    end

    on_intel do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.1.0/veil-x86_64-unknown-linux-gnu"
      sha256 "6fd91133d85a9d4704b514cc9a98f5c874d21430159c1ee85c40cf981b4fbaee"
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
