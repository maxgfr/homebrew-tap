class Obscura < Formula
  desc "Open, check and repair recordings from the obscura web studio"
  homepage "https://github.com/maxgfr/obscura"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/obscura/releases/download/cli-v1.2.1/obscura-aarch64-apple-darwin"
      sha256 "ba936006df8096c7c948a36d5bc5e2f7283b0c143eeea47a22d8640f66691ddf"
    end

    on_intel do
      url "https://github.com/maxgfr/obscura/releases/download/cli-v1.2.1/obscura-x86_64-apple-darwin"
      sha256 "c8b6514933466e9bcfd3c3aad50874289444dbb2a7449ae716691347b826b978"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/obscura/releases/download/cli-v1.2.1/obscura-aarch64-unknown-linux-gnu"
      sha256 "0a377e05252828631798bec5a8ef20a5c307bd52f0eb0b917e9b89d7b8eb2c45"
    end

    on_intel do
      url "https://github.com/maxgfr/obscura/releases/download/cli-v1.2.1/obscura-x86_64-unknown-linux-gnu"
      sha256 "1e58b0ac6ba43e5d03d0f8d4d4b997689a75cf08fb84ae31c8362d21b40b4105"
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
