class Nuee < Formula
  desc "Share compute, files and hosting over a private short-lived cloud from one link"
  homepage "https://github.com/maxgfr/nuee"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/nuee/releases/download/v0.9.0/nuee-aarch64-apple-darwin"
      sha256 "14a714e2e9ebec75f53a56adf2ac201b9b61c2bffeaff38e00ba110fc551f27c"
    end

    on_intel do
      url "https://github.com/maxgfr/nuee/releases/download/v0.9.0/nuee-x86_64-apple-darwin"
      sha256 "e74bbc52259eae255aabb39408e8a7868b02d6a4aae02c1f5c0a49b415a55057"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/nuee/releases/download/v0.9.0/nuee-aarch64-unknown-linux-gnu"
      sha256 "ff0dceb891cb45d496603a34b0b2de5b2ac08c51793179d1a75492babadff695"
    end

    on_intel do
      url "https://github.com/maxgfr/nuee/releases/download/v0.9.0/nuee-x86_64-unknown-linux-gnu"
      sha256 "a98ad728ce976dc24413d0dd8178758f80a70d881d5168b652289ddcbe0cb4de"
    end
  end

  def install
    binary = Dir["nuee-*"].first

    if binary.nil?
      opoo "No nuee binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "nuee"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nuee --version")
    # Offline self-check: wasm golden outputs, links, signatures, encryption, an in-memory swarm.
    assert_match "selftest ok", shell_output("#{bin}/nuee selftest")
    # The identity key is created once in the config dir and read back on the next run.
    config = testpath/"config"
    first = shell_output("#{bin}/nuee --config-dir #{config} id").lines.first.strip
    assert_match(/\A\h{64}\z/, first)
    assert_equal first, shell_output("#{bin}/nuee --config-dir #{config} id").lines.first.strip
    assert_path_exists config/"secret.key"
  end
end
