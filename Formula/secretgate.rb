class Secretgate < Formula
  desc "Local secrets firewall for coding agents (Claude Code, Codex, OpenCode)"
  homepage "https://github.com/maxgfr/secretgate"
  version "1.6.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.6.3/secretgate-macos-arm64"
      sha256 "61a9beaf79abe208635d5c130b82711c20e3340158ac7c71904ba31fdc46b480"
    end

    on_intel do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.6.3/secretgate-macos-x64"
      sha256 "cadd831dbdbe328971629beff06689844f1f03e4d35922029dbbabb18d27f298"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.6.3/secretgate-linux-arm64"
      sha256 "df06fe8d710b7f22ab1eda7ad99586b009b515b0d9b7c9375d3b5d26d86ea7ab"
    end

    on_intel do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.6.3/secretgate-linux-x64"
      sha256 "4f465329c7cd24873169592383eb5adb1a0064e7889fac48a78dc7e5b84e4fb5"
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
