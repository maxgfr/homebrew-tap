class Aparte < Formula
  desc "Command-line companion of the Aparté private, end-to-end encrypted AI chat"
  homepage "https://github.com/maxgfr/aparte"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/aparte/releases/download/v1.6.0/aparte-aarch64-apple-darwin"
      sha256 "10a3b6636932ec3064a30eb772d832c6ea4c67737869ea69096ec37fb35d625c"
    end

    on_intel do
      url "https://github.com/maxgfr/aparte/releases/download/v1.6.0/aparte-x86_64-apple-darwin"
      sha256 "df70120335a7db85540f46ad38feae72e73acd738c20e9ee955153f31602f131"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/aparte/releases/download/v1.6.0/aparte-aarch64-unknown-linux-gnu"
      sha256 "08c3ff330b7726c38dac0a6cbb37a90cd74c025f1371d5a82fc18e0ba543ddbf"
    end

    on_intel do
      url "https://github.com/maxgfr/aparte/releases/download/v1.6.0/aparte-x86_64-unknown-linux-gnu"
      sha256 "aeb2e4afebdf44d9f2a5cc9cdcd34757216d5c422dbac08f48abca27052e2edd"
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
