class Secretgate < Formula
  desc "Local secrets firewall for coding agents (Claude Code, Codex, OpenCode)"
  homepage "https://github.com/maxgfr/secretgate"
  version "1.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.6.0/secretgate-macos-arm64"
      sha256 "20fa1af51775f31a4ed4d3b982582dec3526994acbf7a00c8ce839ad923261a7"
    end

    on_intel do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.6.0/secretgate-macos-x64"
      sha256 "ee0077a0d9eefefc0be0914d9c26ef5e1385f5344d28cca4c95dbe13c916072a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.6.0/secretgate-linux-arm64"
      sha256 "4eb461d5779d887691a1473de56b3b3e8c7a38c789be16f33066a96e9ceb7bf6"
    end

    on_intel do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.6.0/secretgate-linux-x64"
      sha256 "695a2470399b211025fa7d1329e7c7640bb7b541b5a42646d9ae18a6c63be3f8"
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
