class Nuee < Formula
  desc "Private, short-lived cloud from one link: verified compute, files and hosting"
  homepage "https://github.com/maxgfr/nuee"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/nuee/releases/download/v0.3.0/nuee-aarch64-apple-darwin"
      sha256 "97f3bb597638456c1ddd54b9dca9a3cb7e7970ed7f94699a5a36f8d7120ff08d"
    end

    on_intel do
      url "https://github.com/maxgfr/nuee/releases/download/v0.3.0/nuee-x86_64-apple-darwin"
      sha256 "5a2b368fa53a6556f9409fd2823247d73ab48acbd7378248669eefe200f39859"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/nuee/releases/download/v0.3.0/nuee-aarch64-unknown-linux-gnu"
      sha256 "d9b3b96d5cd9b3e213edd9a94a0d56d85d274485ee99994f0564c03ea553ef38"
    end

    on_intel do
      url "https://github.com/maxgfr/nuee/releases/download/v0.3.0/nuee-x86_64-unknown-linux-gnu"
      sha256 "08ae5b4ee6788cd1ea3fb5ea88beb2279aeeef1e4482688884827fc9c4d44366"
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
