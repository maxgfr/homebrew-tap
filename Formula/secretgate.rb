class Secretgate < Formula
  desc "Redact secrets locally before they reach Claude Code, Codex or OpenCode"
  homepage "https://github.com/maxgfr/secretgate"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.9.0/secretgate-macos-arm64"
      sha256 "be78c57c98db7df8d19cc92d22eca38310f5e34811423821f3e3ae155d4a846d"
    end

    on_intel do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.9.0/secretgate-macos-x64"
      sha256 "547b27c1ca0685262e84b6acb6e33a9911cefc7162f30b1499b25c8ca3a0e5d2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.9.0/secretgate-linux-arm64"
      sha256 "0695d4114210df5681d7b6276323969c2998e0998650e287353530e2310a0276"
    end

    on_intel do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.9.0/secretgate-linux-x64"
      sha256 "1a3ae7d7acdad5860e6bfd5091e8f3f51d34e042f6d2f135b2bb2d659fa00721"
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
