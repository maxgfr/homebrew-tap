class Nubes < Formula
  desc "Sync a folder with a GitHub repository you own"
  homepage "https://github.com/maxgfr/nubes"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/nubes/releases/download/cli-v1.0.0/nubes-aarch64-apple-darwin"
      sha256 "1c0507b65b70759262ae153572bad12642066cf21643920bfb208b4d26b71a2c"
    end

    on_intel do
      url "https://github.com/maxgfr/nubes/releases/download/cli-v1.0.0/nubes-x86_64-apple-darwin"
      sha256 "f0218fd2d8bfb94e5cf959a07f111b071b91f8f84dfbab22694736a9d4e8ccb7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/nubes/releases/download/cli-v1.0.0/nubes-aarch64-unknown-linux-gnu"
      sha256 "76874dd06de58c51e530dbe2c49676176cf234e8931917e6239e12d0d3091172"
    end

    on_intel do
      url "https://github.com/maxgfr/nubes/releases/download/cli-v1.0.0/nubes-x86_64-unknown-linux-gnu"
      sha256 "dbbc0b78e3656e6ddea548b477b606957babc320901c6f1586a946e4d6433aad"
    end
  end

  def install
    binary = Dir["nubes-*"].first

    if binary.nil?
      opoo "No nubes binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "nubes"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nubes --version")
    # Offline: the sync engine replays its shared test vectors.
    assert_match "selftest ok", shell_output("#{bin}/nubes selftest")
    assert_match "name: nubes", shell_output("#{bin}/nubes skill")
  end
end
