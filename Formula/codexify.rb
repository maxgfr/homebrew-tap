class Codexify < Formula
  desc "Codex toolbelt for profiles, notifications, backup, and keep-awake"
  homepage "https://github.com/maxgfr/codexify"
  version "0.1.0"
  license "MIT"

  depends_on "maxgfr/tap/conforme"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/codexify/releases/download/v0.1.0/codexify-macos-arm64"
      sha256 "1803e3dc61e1096cb51e332f54cffd8749a68ccb8927b1bc32d6316678f5e4ea"
    end

    on_intel do
      url "https://github.com/maxgfr/codexify/releases/download/v0.1.0/codexify-macos-x64"
      sha256 "ff94359dd1b2cf06e759830a9cdc843787119a3639ca170ee5b4e95c6fcfd05a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/codexify/releases/download/v0.1.0/codexify-linux-arm64"
      sha256 "69920d3adcea75cb3d15cb5dd94bd80b936d11345b8c48d982bf51f9745b268a"
    end

    on_intel do
      url "https://github.com/maxgfr/codexify/releases/download/v0.1.0/codexify-linux-x64"
      sha256 "4a2f7fbaee6ca01fb552de1f81a9448e8c36ff444259125234ae823b61a512b8"
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
    assert_match "codexify 0.1.0", shell_output("#{bin}/codexify --version")
  end
end
