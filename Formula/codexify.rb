class Codexify < Formula
  desc "Codex toolbelt for profiles, notifications, backup, and keep-awake"
  homepage "https://github.com/maxgfr/codexify"
  license "MIT"

  depends_on "maxgfr/tap/conforme"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.6/codexify-macos-arm64"
      sha256 "c869fda0115ff44fcd76d593eb5176d15c3823387c9fffe295879841d7c8c38a"
    end

    on_intel do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.6/codexify-macos-x64"
      sha256 "8b804dca4f9789ce8be7854e1fb7a4bfc70fbe83a7442f5789c36755336cd625"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.6/codexify-linux-arm64"
      sha256 "a2bc54f6e42cc5508b6d6f970444f3000de312fc12323b920a32413ebd0af39f"
    end

    on_intel do
      url "https://github.com/maxgfr/codexify/releases/download/v0.2.6/codexify-linux-x64"
      sha256 "7004bcc4078d52e0a6ec4d6985eccd9c922c3cb35f7c3f5bee02e7b2e20b5fed"
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
    assert_match "codexify 0.2.6", shell_output("#{bin}/codexify --version")
  end
end
