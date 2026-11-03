class Otpx < Formula
  desc "2FA codes in the terminal and the browser, from one encrypted synced vault"
  homepage "https://github.com/maxgfr/otpx"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/otpx/releases/download/v0.1.0/otpx-aarch64-apple-darwin"
      sha256 "6ada3ff79e82b0be99b6135077457017d21c8ae7a6caf1b46d475321d0a14796"
    end

    on_intel do
      url "https://github.com/maxgfr/otpx/releases/download/v0.1.0/otpx-x86_64-apple-darwin"
      sha256 "7a455f06df721450914392af23c9f2462d571dc1aeb01280e29b2e5689a92c54"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/otpx/releases/download/v0.1.0/otpx-aarch64-unknown-linux-gnu"
      sha256 "ad09085991da5e7a95679326383ce21cd969958fc151799b66fafd13022546ea"
    end

    on_intel do
      url "https://github.com/maxgfr/otpx/releases/download/v0.1.0/otpx-x86_64-unknown-linux-gnu"
      sha256 "2a6187bd124dce6064a20552ec87e9e60ca867e90fea36bfe3417b1a0161a764"
    end
  end

  def install
    binary = Dir["otpx-*"].first

    if binary.nil?
      opoo "No otpx binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "otpx"
    generate_completions_from_executable(bin/"otpx", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/otpx --version")
    # Offline self-check: RFC vectors, vault encryption, every format, share links, QR codes.
    assert_match "selftest ok", shell_output("#{bin}/otpx selftest")
    # A throwaway vault (keys in a file, not the keychain) gives the RFC 6238 code at T=59.
    ENV["OTPX_CONFIG_DIR"] = (testpath/"config").to_s
    ENV["OTPX_DATA_DIR"] = (testpath/"data").to_s
    ENV["OTPX_KEYCHAIN"] = "0"
    ENV["OTPX_NO_INPUT"] = "1"
    pipe_output("#{bin}/otpx init --password-stdin", "brew test passphrase\n", 0)
    ENV["OTPX_PASSWORD"] = "brew test passphrase"
    system bin/"otpx", "--offline", "add",
           "otpauth://totp/Test:rfc?secret=GEZDGNBVGY3TQOJQGEZDGNBVGY3TQOJQ&digits=8&issuer=Test"
    ENV["OTPX_NOW"] = "59"
    assert_equal "94287082", shell_output("#{bin}/otpx code test").strip
  end
end
