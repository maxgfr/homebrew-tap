class Hush < Formula
  desc "Post-quantum, end-to-end encrypted chat and file transfer"
  homepage "https://github.com/maxgfr/hush"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/hush/releases/download/cli-v3.3.0/hush-aarch64-apple-darwin"
      sha256 "ea1c3c40aff35964052f396a03ab9e51ac726b2dbeae010c5cada159003fbbc1"
    end

    on_intel do
      url "https://github.com/maxgfr/hush/releases/download/cli-v3.3.0/hush-x86_64-apple-darwin"
      sha256 "92b30091d3e58da5e17a9bec99f5fcb9c6f3d25a40f0a77625833920ac3a379c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/hush/releases/download/cli-v3.3.0/hush-aarch64-unknown-linux-gnu"
      sha256 "7977432fa880a9a1f1a5f071bd64bfe4dda3add2cee6c249fe16adbb79875f7d"
    end

    on_intel do
      url "https://github.com/maxgfr/hush/releases/download/cli-v3.3.0/hush-x86_64-unknown-linux-gnu"
      sha256 "00293650f212175977db93749cee19f04e550ac0306bebfb87253434490b32aa"
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
