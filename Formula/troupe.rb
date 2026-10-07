class Troupe < Formula
  desc "Drive a self-hosted Troupe studio (AI actor videos) from the terminal"
  homepage "https://github.com/maxgfr/troupe"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/troupe/releases/download/v0.4.0/troupe-macos-arm64"
      sha256 "3019c9bf604c061b32f85c053a5a9df974ef20447be91efe7f3cba4789fd7948"
    end

    on_intel do
      url "https://github.com/maxgfr/troupe/releases/download/v0.4.0/troupe-macos-x64"
      sha256 "0a07f2ec9a77a7c6ec0c5811895fa82e9aa074825067677d8f3f95186b3383e1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/troupe/releases/download/v0.4.0/troupe-linux-arm64"
      sha256 "43e19728c41d0227ac869bb000d65186503cbceeff3dfa7a96184ed1cda656df"
    end

    on_intel do
      url "https://github.com/maxgfr/troupe/releases/download/v0.4.0/troupe-linux-x64"
      sha256 "d966a182f5b23ab97e5ccc2c1a013f8966b8043cab54e589c40ba5219101db7b"
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
