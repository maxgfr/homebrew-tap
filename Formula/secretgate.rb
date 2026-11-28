class Secretgate < Formula
  desc "Redact secrets locally before they reach Claude Code, Codex or OpenCode"
  homepage "https://github.com/maxgfr/secretgate"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.10.0/secretgate-macos-arm64"
      sha256 "54c8882e6888e45054516a81e993fedebbd4c1ae52cf2930cb8abd7a10086b67"
    end

    on_intel do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.10.0/secretgate-macos-x64"
      sha256 "77313fbcf5d94bcd817f60cd651348d8ec1a48e9bdf42362b9dc8c15ea471c28"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.10.0/secretgate-linux-arm64"
      sha256 "9b01989b7d2bb2587ecdd7c91c73e690674a988608790388206df8d32ae512ea"
    end

    on_intel do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.10.0/secretgate-linux-x64"
      sha256 "826087a2bffcd84011e7c8ee0ada526ecdbb68617d5aaf0f20120e47371a1fab"
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
