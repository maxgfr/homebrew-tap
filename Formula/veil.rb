class Veil < Formula
  desc "Peer-to-peer, end-to-end encrypted file transfer and chat in Veil rooms"
  homepage "https://github.com/maxgfr/veil"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.3.2/veil-aarch64-apple-darwin"
      sha256 "ed5fa7a13c352d60c3ec00ca6b69d80edbcb47da5acb2349339ffbe8da439bac"
    end

    on_intel do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.3.2/veil-x86_64-apple-darwin"
      sha256 "4f6629de929c0dc98226941f4b2e7a819aaeafab0e82e2871bf93a58b065bd89"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.3.2/veil-aarch64-unknown-linux-gnu"
      sha256 "7a9d2571a28330ae8ab47b88e1e5bcfe36989f3ba1d6c9f9443b738d98d6e6c7"
    end

    on_intel do
      url "https://github.com/maxgfr/veil/releases/download/cli-v0.3.2/veil-x86_64-unknown-linux-gnu"
      sha256 "dab37aadacf2a4bea80be8b12505cdc9d0cd33b3fd68fa173923572928bd3918"
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
