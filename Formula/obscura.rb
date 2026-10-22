class Obscura < Formula
  desc "Open, check and repair recordings from the obscura web studio"
  homepage "https://github.com/maxgfr/obscura"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/obscura/releases/download/cli-v1.2.0/obscura-aarch64-apple-darwin"
      sha256 "d434c45f6cfdd2d77cb01facb25ed9be165e1eac51aefa5752b6115919fa7fc4"
    end

    on_intel do
      url "https://github.com/maxgfr/obscura/releases/download/cli-v1.2.0/obscura-x86_64-apple-darwin"
      sha256 "220cb72a3cee92e29baa579b86271371d379b0b3177cc66760713929e98bc298"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/obscura/releases/download/cli-v1.2.0/obscura-aarch64-unknown-linux-gnu"
      sha256 "7013f3c8c1392529e4ddc6997fe39c359dac74dbc6a1abe3a52afefce4ebd715"
    end

    on_intel do
      url "https://github.com/maxgfr/obscura/releases/download/cli-v1.2.0/obscura-x86_64-unknown-linux-gnu"
      sha256 "f898d02b084b1f1dd15d49f5b4ab19fdb6dc6abd2d8ed1df58da15237c443305"
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
