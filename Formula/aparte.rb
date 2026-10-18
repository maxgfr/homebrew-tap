class Aparte < Formula
  desc "Command-line companion of the Aparté private, end-to-end encrypted AI chat"
  homepage "https://github.com/maxgfr/aparte"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/aparte/releases/download/v1.2.0/aparte-aarch64-apple-darwin"
      sha256 "f8cf7485eb00f9f62d8c96a372ed71cd9e00802fcee2decc9507136df1bf715e"
    end

    on_intel do
      url "https://github.com/maxgfr/aparte/releases/download/v1.2.0/aparte-x86_64-apple-darwin"
      sha256 "50a1944dc2e6b049db61f29df5bab5546fe4012221ada35c5d156417a40297cb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/aparte/releases/download/v1.2.0/aparte-aarch64-unknown-linux-gnu"
      sha256 "886316a7ff04427ecd02788cf137a21ce3ee03040cd0d417cf44fc530273e2dc"
    end

    on_intel do
      url "https://github.com/maxgfr/aparte/releases/download/v1.2.0/aparte-x86_64-unknown-linux-gnu"
      sha256 "34a9c13e94995bdb2d740edca2f5f4f49472a86b13a786482ef2fa989a015038"
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
