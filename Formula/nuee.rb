class Nuee < Formula
  desc "Share compute, files and hosting over a private short-lived cloud from one link"
  homepage "https://github.com/maxgfr/nuee"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/nuee/releases/download/v0.8.0/nuee-aarch64-apple-darwin"
      sha256 "0b003009baf48650d4b9fbf2e486fa59d9b7a477883a3f2e69782f7b902c7ac4"
    end

    on_intel do
      url "https://github.com/maxgfr/nuee/releases/download/v0.8.0/nuee-x86_64-apple-darwin"
      sha256 "d8eba6125b946b6aa4f3469eb01350705fe1fd55da7faff5a070d82749f90e63"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/nuee/releases/download/v0.8.0/nuee-aarch64-unknown-linux-gnu"
      sha256 "ad66279a0237c108c5d9b0293669eb7af2a2b3db1266bf316d8c0ddd9799ee04"
    end

    on_intel do
      url "https://github.com/maxgfr/nuee/releases/download/v0.8.0/nuee-x86_64-unknown-linux-gnu"
      sha256 "b39fc4d08935d0b4799baca5d36a59f6c58b418a088efedca87ad4c99c63cb80"
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
