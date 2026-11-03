class Otpx < Formula
  desc "2FA codes in the terminal and the browser, from one encrypted synced vault"
  homepage "https://github.com/maxgfr/otpx"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/otpx/releases/download/v0.1.1/otpx-aarch64-apple-darwin"
      sha256 "825149c83000558a7433ce9fb7dc120a3ec7acceb4b1a8adabc210ab754e1ba1"
    end

    on_intel do
      url "https://github.com/maxgfr/otpx/releases/download/v0.1.1/otpx-x86_64-apple-darwin"
      sha256 "bb4ceecd58eb5426a61c9c985123e65f5cd21611f6cf636a63fe1ebd33a402b9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/otpx/releases/download/v0.1.1/otpx-aarch64-unknown-linux-gnu"
      sha256 "dc62339e25939811afdc0f8eaed0e2e5004665684703557f4c5e4c3fc5d557e8"
    end

    on_intel do
      url "https://github.com/maxgfr/otpx/releases/download/v0.1.1/otpx-x86_64-unknown-linux-gnu"
      sha256 "c1c87981d2b677aaa552ee484d71b278fae539e81404871e1a9f31a8130ba3f6"
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
