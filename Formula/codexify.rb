class Codexify < Formula
  desc "Codex toolbelt for profiles, notifications, backup, and keep-awake"
  homepage "https://github.com/maxgfr/codexify"
  license "MIT"

  depends_on "maxgfr/tap/conforme"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.4/codexify-macos-arm64"
      sha256 "6436484f773820235179f2e9a632d37d31a524c3ff753e317b8d3c3ced64afc7"
    end

    on_intel do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.4/codexify-macos-x64"
      sha256 "c6e698051f316f8a13a4255e5fb5a3d0592d92da115dc3993e6982d2d6156773"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.4/codexify-linux-arm64"
      sha256 "4f9bab3dfa4313fe0d41a3f94ab3508a81f93d7149a277718220680a748d328c"
    end

    on_intel do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.4/codexify-linux-x64"
      sha256 "cc4a7769e8ad5e4e3faac29773b085d894fdb42b591216f5653c58ca4eb4cb7d"
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
    assert_match "codexify 0.2.4", shell_output("#{bin}/codexify --version")
  end
end
