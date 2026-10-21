class Secretgate < Formula
  desc "Local secrets firewall for coding agents (Claude Code, Codex, OpenCode)"
  homepage "https://github.com/maxgfr/secretgate"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.8.0/secretgate-macos-arm64"
      sha256 "1bdd99f4ac8a87cac57fc6bafd83999eec523f4770d5c4558f1945d163d069cc"
    end

    on_intel do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.8.0/secretgate-macos-x64"
      sha256 "91de60fc9171291179f13c93699b2d205bef58806613482e9224a548fb7692ba"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.8.0/secretgate-linux-arm64"
      sha256 "20459e3836002c13541a43b5ae6d1bb9166c82f16fbd5e33fe0fa3212f9d2351"
    end

    on_intel do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.8.0/secretgate-linux-x64"
      sha256 "f29c2149f6d02888d39cd0c6ec69555eb9adca259f14dc42c4db4f09ce0a0025"
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
