class Codexify < Formula
  desc "Codex toolbelt for profiles, notifications, backup, and keep-awake"
  homepage "https://github.com/maxgfr/codexify"
  license "MIT"

  depends_on "maxgfr/tap/conforme"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.1/codexify-macos-arm64"
      sha256 "f25b4111425323dc85e20642b22ce27a4834d544370b991e4458724ffc9d3894"
    end

    on_intel do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.1/codexify-macos-x64"
      sha256 "6ff84e9bfea24557a849fc8edf8f4be69edb95f11d1eb8f72a0ee67cf9254e6f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.1/codexify-linux-arm64"
      sha256 "cb419896be7f92b417d908143b9a5f1fda87e0cfba516253f91cf44435b9b3e5"
    end

    on_intel do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.1/codexify-linux-x64"
      sha256 "bfbc749a0ad6ef13fbcb8b77a34a21f58a4d489abbfb189e5d91c3b663a668a6"
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
    assert_match "codexify 0.2.1", shell_output("#{bin}/codexify --version")
  end
end
