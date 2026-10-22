class Hush < Formula
  desc "Post-quantum, end-to-end encrypted chat and file transfer"
  homepage "https://github.com/maxgfr/hush"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/hush/releases/download/cli-v1.0.0/hush-aarch64-apple-darwin"
      sha256 "ccdd6e523ab2e75854c42090ae660b0fd84436755516c4a105c3a141092ff72e"
    end

    on_intel do
      url "https://github.com/maxgfr/hush/releases/download/cli-v1.0.0/hush-x86_64-apple-darwin"
      sha256 "1ce7184edc5ba64eefed18f4f6b4b22d88436588672e67aa611e85154e59845d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/hush/releases/download/cli-v1.0.0/hush-aarch64-unknown-linux-gnu"
      sha256 "a87ddfa166416a85dff83dac4552c7bab7956bce6507b010f1ad72d56d36445f"
    end

    on_intel do
      url "https://github.com/maxgfr/hush/releases/download/cli-v1.0.0/hush-x86_64-unknown-linux-gnu"
      sha256 "689e5dd7c58e8c1cbea498a7aa174f201c10e16b04eaa837866ad4451dd82af7"
    end
  end

  def install
    binary = Dir["hush-*"].first

    if binary.nil?
      opoo "No hush binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "hush"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hush --version")
    # A fresh link, generated offline: the same format the web app opens.
    link = shell_output("#{bin}/hush new").strip
    assert_match %r{^https://maxgfr\.github\.io/hush/#[1-9]\.s\.[A-Za-z0-9_-]{43}\.[0-9a-z]+$}, link
  end
end
