class Secretgate < Formula
  desc "Local secrets firewall for coding agents (Claude Code, Codex, OpenCode)"
  homepage "https://github.com/maxgfr/secretgate"
  version "1.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.7.0/secretgate-macos-arm64"
      sha256 "b5292652ddf6f7dcbcd6d8e4f520946d194f15c36c39152bd96fc1abd03cf3c9"
    end

    on_intel do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.7.0/secretgate-macos-x64"
      sha256 "b1ec9eb33ced689ea4ab7c2989672a457f81204b7e0492935a13db3921fc7cec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.7.0/secretgate-linux-arm64"
      sha256 "8205f1f929c348db638c32b522927fc244d60abd2794a3e6fcd3c954cbf5281f"
    end

    on_intel do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.7.0/secretgate-linux-x64"
      sha256 "fcb0cb966d5d7aba37086b61a7b1508f592f63e6bfe94a7b8c2e94ca77021d99"
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
