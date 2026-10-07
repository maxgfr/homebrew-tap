class Troupe < Formula
  desc "Drive a self-hosted Troupe studio (AI actor videos) from the terminal"
  homepage "https://github.com/maxgfr/troupe"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/troupe/releases/download/v0.5.0/troupe-macos-arm64"
      sha256 "24ac9df003dae5cfd1fcf3237bf9d2f5b230aaade1855b7ac57155f0e5f5f635"
    end

    on_intel do
      url "https://github.com/maxgfr/troupe/releases/download/v0.5.0/troupe-macos-x64"
      sha256 "42d37699004c4f4552e72e12891440f596d06de0ca756ef3d379a573d28bda12"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/troupe/releases/download/v0.5.0/troupe-linux-arm64"
      sha256 "1d8f86b6fb3bffef7547e3e498573d392a9cb2cb30390a6c454443289e5a96ae"
    end

    on_intel do
      url "https://github.com/maxgfr/troupe/releases/download/v0.5.0/troupe-linux-x64"
      sha256 "ec98962d0b05aafd94e4c91811d0a7011ce368dc843fe138d87fb9c0bb80051b"
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
