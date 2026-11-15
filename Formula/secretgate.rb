class Secretgate < Formula
  desc "Redact secrets locally before they reach Claude Code, Codex or OpenCode"
  homepage "https://github.com/maxgfr/secretgate"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.8.1/secretgate-macos-arm64"
      sha256 "828b2cedf1e837841abb42f9a4b13aa295b1cd5979dd1574e663951489aed732"
    end

    on_intel do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.8.1/secretgate-macos-x64"
      sha256 "b8e581fd233df3da03a6093524aff6b37bb57a2de17d2baeb8381001a674ea1d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.8.1/secretgate-linux-arm64"
      sha256 "272d9bd55ed33885c1a16c05bd5254f19b3c3d51b4c1205ebba585abcaa5c986"
    end

    on_intel do
      url "https://github.com/maxgfr/secretgate/releases/download/v1.8.1/secretgate-linux-x64"
      sha256 "8e93094438f2416b3785f17d0316ba745f718149f701fd49f3c5a387aa54c9bc"
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
