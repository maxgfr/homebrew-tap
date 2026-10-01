class Secretgate < Formula
  desc "Local secrets firewall for coding agents (Claude Code, Codex, OpenCode)"
  homepage "https://github.com/maxgfr/secretgate"
  version "1.6.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.6.1/secretgate-macos-arm64"
      sha256 "fcda9eb992aca98c9528f6ead21b971128bd80af3373e4d7da9d88a046e4b122"
    end

    on_intel do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.6.1/secretgate-macos-x64"
      sha256 "63e66217ad38d178251193ee14d0ed436908db077679e2324f12ddfe93020af1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.6.1/secretgate-linux-arm64"
      sha256 "d5c7911d109fecd8f5cb06c91ad6c3205f84588bd022968af8f9365acf5f2eee"
    end

    on_intel do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.6.1/secretgate-linux-x64"
      sha256 "9dc8213e2ab39dff676b21f49895cf82e9e7ca7b1191c54cac0dba87747bb12b"
    end
  end

  def install
    binary = Dir["secretgate-*"].first

    if binary.nil?
      opoo "No secretgate binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "secretgate"
  end

  def caveats
    <<~EOS
      Run `secretgate init` to protect Claude Code / Codex / OpenCode.
      The hooks run a copy pinned under ~/.secretgate/bin, so re-run
      `secretgate init` after each `brew upgrade`.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/secretgate --version")
    # A real offline scan: a fake AWS key id, built by concatenation so no
    # literal credential sits in this file. Findings exit 1.
    fake = "AKIA" + "Q7R2M3XBL4WPZ6TK"
    output = pipe_output("#{bin}/secretgate scan - --no-gitleaks", "aws key #{fake} ok\n", 1)
    assert_match "aws-access-token", output
  end
end
