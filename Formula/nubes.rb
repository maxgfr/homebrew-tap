class Nubes < Formula
  desc "Sync a folder with a GitHub repository you own"
  homepage "https://github.com/maxgfr/nubes"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/nubes/releases/download/cli-v1.3.0/nubes-aarch64-apple-darwin"
      sha256 "169139ea2cadacf1dd7abfe8691952ec211bc29dc804f937d43013dce2f12627"
    end

    on_intel do
      url "https://github.com/maxgfr/nubes/releases/download/cli-v1.3.0/nubes-x86_64-apple-darwin"
      sha256 "5382caf42b4570cd0d6cdd1ff3aafe31b0c22dbd9f4d14932a17e3eeed0ce5ce"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/nubes/releases/download/cli-v1.3.0/nubes-aarch64-unknown-linux-gnu"
      sha256 "8f9df6bd27295740ab1d7ce52b8c26f9fae2c5871975c6aa1744a4f3b87f8854"
    end

    on_intel do
      url "https://github.com/maxgfr/nubes/releases/download/cli-v1.3.0/nubes-x86_64-unknown-linux-gnu"
      sha256 "01e2c5a8f98fb92f7708d1ea8dda61a53e237455a931085a3994255451d1b8e2"
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
