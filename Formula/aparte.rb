class Aparte < Formula
  desc "Command-line companion of the Aparté private, end-to-end encrypted AI chat"
  homepage "https://github.com/maxgfr/aparte"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/aparte/releases/download/v1.6.1/aparte-aarch64-apple-darwin"
      sha256 "e03bfbb96681027d60a9aeb45d12cc2d0e10bf870b634ebb7d9fb6ccab6323cb"
    end

    on_intel do
      url "https://github.com/maxgfr/aparte/releases/download/v1.6.1/aparte-x86_64-apple-darwin"
      sha256 "0e8fa6e535375a308f0b49a9127e5ef4c3699294d9c474b2a3c100ea80552483"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/aparte/releases/download/v1.6.1/aparte-aarch64-unknown-linux-gnu"
      sha256 "5d0cf2d24fd297c46c4b8948c40c001cdf761c85fd6c18bd0c5ba6c23df9bf07"
    end

    on_intel do
      url "https://github.com/maxgfr/aparte/releases/download/v1.6.1/aparte-x86_64-unknown-linux-gnu"
      sha256 "42308e9bfcf6f508305e77dc2ddb93929c6802305e8965486931f291b1ff451c"
    end
  end

  def install
    binary = Dir["aparte-*"].first

    if binary.nil?
      opoo "No aparte binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "aparte"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aparte --version")
    # Offline self-check of the aparte/1 format and crypto: no key, no network, no files.
    assert_match "selftest: all checks passed", shell_output("#{bin}/aparte selftest")
    assert_match '{"event":"selftest","ok":true}', shell_output("#{bin}/aparte --json selftest")
  end
end
