class Nuee < Formula
  desc "Share compute, files and hosting over a private short-lived cloud from one link"
  homepage "https://github.com/maxgfr/nuee"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/nuee/releases/download/v0.3.1/nuee-aarch64-apple-darwin"
      sha256 "f7796618de3b575d7c4d7742c9bf3e02bce79385d9f14f2a20059e4f9127539e"
    end

    on_intel do
      url "https://github.com/maxgfr/nuee/releases/download/v0.3.1/nuee-x86_64-apple-darwin"
      sha256 "6161ce7fa5c2421552f8fbb99545adf6c9d7dfcebd79b01c6daec475b25a6b1f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/nuee/releases/download/v0.3.1/nuee-aarch64-unknown-linux-gnu"
      sha256 "05010ce313b9a09062b3007c1f1bfea83b2037dbc05ae15801570575c18b317c"
    end

    on_intel do
      url "https://github.com/maxgfr/nuee/releases/download/v0.3.1/nuee-x86_64-unknown-linux-gnu"
      sha256 "8316ddeff49c743ee78b52813313165148cfee45642f6e2db95796f82c659024"
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
