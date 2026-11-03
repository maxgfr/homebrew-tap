class Aparte < Formula
  desc "Command-line companion of the Aparté private, end-to-end encrypted AI chat"
  homepage "https://github.com/maxgfr/aparte"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/aparte/releases/download/v1.6.3/aparte-aarch64-apple-darwin"
      sha256 "886695b59f7fe37e2ac72ab8b7edae5664fe23f338bf992e150c04b1bdc1937a"
    end

    on_intel do
      url "https://github.com/maxgfr/aparte/releases/download/v1.6.3/aparte-x86_64-apple-darwin"
      sha256 "94d4fe1db39b815079d962e9a5fbea881f4905bcc63d8013dc24ac8af80ef316"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/aparte/releases/download/v1.6.3/aparte-aarch64-unknown-linux-gnu"
      sha256 "32be0b696ba395126f668651be2ff5f3261ade39be1437c91eb5e169272880f7"
    end

    on_intel do
      url "https://github.com/maxgfr/aparte/releases/download/v1.6.3/aparte-x86_64-unknown-linux-gnu"
      sha256 "1716d722bc8f4a30fff9acfc80b0e6de2b61ba8838eb071987bad2772582944b"
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
