class Troupe < Formula
  desc "Drive a self-hosted Troupe studio (AI actor videos) from the terminal"
  homepage "https://github.com/maxgfr/troupe"
  version "0.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/troupe/releases/download/v0.0.0/troupe-macos-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end

    on_intel do
      url "https://github.com/maxgfr/troupe/releases/download/v0.0.0/troupe-macos-x64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/troupe/releases/download/v0.0.0/troupe-linux-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end

    on_intel do
      url "https://github.com/maxgfr/troupe/releases/download/v0.0.0/troupe-linux-x64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
