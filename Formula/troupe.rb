class Troupe < Formula
  desc "Drive a self-hosted Troupe studio for AI actor videos from the terminal"
  homepage "https://github.com/maxgfr/troupe"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/troupe/releases/download/v0.9.0/troupe-macos-arm64"
      sha256 "0a73ef68ada2a41f34d5eaa920494196732144f9c7c184fbd1beb809043ff5ec"
    end

    on_intel do
      url "https://github.com/maxgfr/troupe/releases/download/v0.9.0/troupe-macos-x64"
      sha256 "406474ef27c906bd9241a1cd4f5c2be072e2b1986d09f9ec5e5feb6c6259ee7a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/troupe/releases/download/v0.9.0/troupe-linux-arm64"
      sha256 "0b436f7b88bdf84193c69e0adb9bfe21f55a78d4f01a4ae7bcbd3586c9db2329"
    end

    on_intel do
      url "https://github.com/maxgfr/troupe/releases/download/v0.9.0/troupe-linux-x64"
      sha256 "42d6535d153bcf23d082181a9060e12bb2630eb5108468bc36f4cc24e2fb5c3c"
    end
  end

  def install
    binary = Dir["troupe-*"].first
    odie "No troupe binary found" if binary.nil?

    chmod 0755, binary
    bin.install binary => "troupe"
  end

  def caveats
    <<~EOS
      The studio itself is not installed here: run it with Docker
      (https://github.com/maxgfr/troupe#quick-start), then
        troupe login --url http://localhost:3100
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/troupe --version").strip
    # No studio needed: the address of its Projects page.
    ENV["TROUPE_CONFIG_DIR"] = testpath/"config"
    assert_equal "http://127.0.0.1:9/dashboard",
                 shell_output("#{bin}/troupe open --print --url http://127.0.0.1:9").strip
  end
end
