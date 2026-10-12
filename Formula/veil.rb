class Veil < Formula
  desc "Peer-to-peer, end-to-end encrypted file transfer and chat in Veil rooms"
  homepage "https://github.com/maxgfr/veil"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.2.0/veil-aarch64-apple-darwin"
      sha256 "6f293373e4b57a1fcf81dc871e8373236a0613fb773df68eb0adbec541040653"
    end

    on_intel do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.2.0/veil-x86_64-apple-darwin"
      sha256 "971c7f9c58536b7b659894cf0c9b8728db0c65d4b14e479c71bd718927f98c44"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.2.0/veil-aarch64-unknown-linux-gnu"
      sha256 "b71e56c220ed8955655ccf05086de764374487db811c43adf1a91eeabdb24332"
    end

    on_intel do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.2.0/veil-x86_64-unknown-linux-gnu"
      sha256 "47d26769b7f1369351b4b0972e3abbe4e044ce21e62c10f3baf08c2eb62116a4"
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
