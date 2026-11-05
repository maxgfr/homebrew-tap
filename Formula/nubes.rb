class Nubes < Formula
  desc "Sync a folder with a GitHub repository you own"
  homepage "https://github.com/maxgfr/nubes"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/nubes/releases/download/cli-v1.2.0/nubes-aarch64-apple-darwin"
      sha256 "b699f1e4c59cfa7c513272a65804874c810c4203630ad6bba73fe5aac4a4917b"
    end

    on_intel do
      url "https://github.com/maxgfr/nubes/releases/download/cli-v1.2.0/nubes-x86_64-apple-darwin"
      sha256 "8f9cb3964315309dae6eb22fb628a5a29c5433d8f931cc42601cf4be15c7a029"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/nubes/releases/download/cli-v1.2.0/nubes-aarch64-unknown-linux-gnu"
      sha256 "e3e87c5bf387843db0ab43aef06b63441b85d77ae6c86f011eec10b07a378030"
    end

    on_intel do
      url "https://github.com/maxgfr/nubes/releases/download/cli-v1.2.0/nubes-x86_64-unknown-linux-gnu"
      sha256 "08bc04f635d34fcdc17d050a83c789a0bc01cd356401e692ed7ef121f0526206"
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
