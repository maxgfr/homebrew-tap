class Otpx < Formula
  desc "2FA codes in the terminal and the browser, from one encrypted synced vault"
  homepage "https://github.com/maxgfr/otpx"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/otpx/releases/download/v0.2.0/otpx-aarch64-apple-darwin"
      sha256 "dbd716b5158d2ce4034795cc7b44fb1ffdce24bbd1b6c2115389d533ab2275d7"
    end

    on_intel do
      url "https://github.com/maxgfr/otpx/releases/download/v0.2.0/otpx-x86_64-apple-darwin"
      sha256 "e751399353a14f559ee9e263dc87773163c0e4524325f4787182f127f77940e1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/otpx/releases/download/v0.2.0/otpx-aarch64-unknown-linux-gnu"
      sha256 "a423e4715b7f4ad3f907600210b4a0a70087dd703b14df8666de2640895cf82a"
    end

    on_intel do
      url "https://github.com/maxgfr/otpx/releases/download/v0.2.0/otpx-x86_64-unknown-linux-gnu"
      sha256 "37222cd84f2524f626f32a81162370bb8301b49e92d09e166c4eaa6e0ec5bb6c"
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
