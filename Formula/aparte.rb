class Aparte < Formula
  desc "Command-line companion of the Aparté private, end-to-end encrypted AI chat"
  homepage "https://github.com/maxgfr/aparte"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/aparte/releases/download/v1.3.1/aparte-aarch64-apple-darwin"
      sha256 "12ddda7997a08f896b41d6a89bb4d7028aa6fc7295542e52421eff5c02748e12"
    end

    on_intel do
      url "https://github.com/maxgfr/aparte/releases/download/v1.3.1/aparte-x86_64-apple-darwin"
      sha256 "85317fa64f49db4223bc9e63a3b418cd3eeca68bfd09a159687b3adb7b9f3b48"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/aparte/releases/download/v1.3.1/aparte-aarch64-unknown-linux-gnu"
      sha256 "34e2ac8fc85df50a3f5313ca202f92262c42fe381655460fe3b38b290915e60c"
    end

    on_intel do
      url "https://github.com/maxgfr/aparte/releases/download/v1.3.1/aparte-x86_64-unknown-linux-gnu"
      sha256 "caa76b44564a5b466f28c178ac8adf02051e8921dba6a762c05e37ea487e440f"
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
