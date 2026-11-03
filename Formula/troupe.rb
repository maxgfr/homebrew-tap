class Troupe < Formula
  desc "Drive a self-hosted Troupe studio (AI actor videos) from the terminal"
  homepage "https://github.com/maxgfr/troupe"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/troupe/releases/download/v0.5.6/troupe-macos-arm64"
      sha256 "1e74f61b6b080bd14a67f2d3c6bf597d33d32dc79495f28f55e22edc980412b0"
    end

    on_intel do
      url "https://github.com/maxgfr/troupe/releases/download/v0.5.6/troupe-macos-x64"
      sha256 "2f010a15f925cd001af4af7f23bb42464a642fed06e80948e3053f41d2a07adb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/troupe/releases/download/v0.5.6/troupe-linux-arm64"
      sha256 "e9ae92b66838ac72683fcf8bc22655b158fdd2aa786569c69b5255ff7775dd75"
    end

    on_intel do
      url "https://github.com/maxgfr/troupe/releases/download/v0.5.6/troupe-linux-x64"
      sha256 "a6d3440752ad86c29e1e98b040f365ffd8967d6a755e6fc4546973bb1c49078d"
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
