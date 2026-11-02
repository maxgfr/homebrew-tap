class Aparte < Formula
  desc "Command-line companion of the Aparté private, end-to-end encrypted AI chat"
  homepage "https://github.com/maxgfr/aparte"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/aparte/releases/download/v1.6.2/aparte-aarch64-apple-darwin"
      sha256 "9b8c259fd8e12d336576a5fb12abaf2e8ac527c108c5601582f3d1ae80db7168"
    end

    on_intel do
      url "https://github.com/maxgfr/aparte/releases/download/v1.6.2/aparte-x86_64-apple-darwin"
      sha256 "653464c307c6382c5e119a9fc48908f73ae06aeee2ce2e115c3b3bc7d85529ff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/aparte/releases/download/v1.6.2/aparte-aarch64-unknown-linux-gnu"
      sha256 "80ce0f0f67360eedd8c004368a42b8011721057e6224ca5a60808e9136c67376"
    end

    on_intel do
      url "https://github.com/maxgfr/aparte/releases/download/v1.6.2/aparte-x86_64-unknown-linux-gnu"
      sha256 "32d13c61512c738f95c5060ba82d156773dc7de6e7a810ca8776987439a405a5"
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
