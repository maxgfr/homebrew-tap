class Codexify < Formula
  desc "Codex toolbelt for profiles, notifications, backup, and keep-awake"
  homepage "https://github.com/maxgfr/codexify"
  license "MIT"

  depends_on "maxgfr/tap/conforme"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.2/codexify-macos-arm64"
      sha256 "8ab9549d8d38901577f8e56236022e0d0cbe7779ea2400d307707a8a64f2327b"
    end

    on_intel do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.2/codexify-macos-x64"
      sha256 "d9c205cb8ae2adc7b469bc205f3b1916a6795ff2de370df35850389f8f7e90c5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.2/codexify-linux-arm64"
      sha256 "c8e9b4a45e24bcda4960c4086469192bf730db4a74f9cabcc728c62b2912fc47"
    end

    on_intel do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.2/codexify-linux-x64"
      sha256 "bfde46e6d7eaa7939002aeb48c6e45040ab4a9af2da93f44be8273894aebd261"
    end
  end

  def install
    binary = Dir["codexify-*"].first

    if binary.nil?
      opoo "No codexify binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "codexify"
  end

  test do
    assert_match "codexify 0.2.2", shell_output("#{bin}/codexify --version")
  end
end
