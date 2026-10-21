class Obscura < Formula
  desc "Open, check and repair recordings from the obscura web studio"
  homepage "https://github.com/maxgfr/obscura"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/obscura/releases/download/cli-v1.0.0/obscura-aarch64-apple-darwin"
      sha256 "4831a8d71a3b7c3c541770b401bee45ce3a9ff8283f5d62c8f21971af713fa9c"
    end

    on_intel do
      url "https://github.com/maxgfr/obscura/releases/download/cli-v1.0.0/obscura-x86_64-apple-darwin"
      sha256 "ffef99883561916e15aa8e7ba99a22c7d9818b748900d7049fffa1dccd3abe22"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/obscura/releases/download/cli-v1.0.0/obscura-aarch64-unknown-linux-gnu"
      sha256 "b0d3c45ef8169d77bfc1044bdbb28cefe52a57f05e95e71824f77395ba397823"
    end

    on_intel do
      url "https://github.com/maxgfr/obscura/releases/download/cli-v1.0.0/obscura-x86_64-unknown-linux-gnu"
      sha256 "abf3757ed8ae372355d073f1673f52d0e9ee0f7778e96927bfadbd5ae4540fcd"
    end
  end

  # homebrew-core ships an unrelated obscura (a headless browser) that also puts
  # `obscura` on PATH, so Homebrew must be told rather than left to fail at link
  # time with nothing the user can act on.
  conflicts_with "obscura", because: "both install an `obscura` binary"

  def install
    binary = Dir["obscura-*"].first

    if binary.nil?
      opoo "No obscura binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "obscura"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/obscura --version")
    # A studio link with the default layout, generated offline: the format the web app opens.
    assert_match %r{^https://maxgfr\.github\.io/obscura/#s=[A-Za-z0-9_-]+$}, shell_output("#{bin}/obscura new").strip
    # Seal and open round trip, wrong passphrase refused, link round trip.
    assert_match "ok: seal, wrong-passphrase, link", shell_output("#{bin}/obscura selftest")
  end
end
