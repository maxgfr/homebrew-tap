class Scopelet < Formula
  desc "Compute before you send: local, recoverable evidence queries for agents"
  homepage "https://github.com/maxgfr/scopelet"
  version "1.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.0.1/scopelet-aarch64-apple-darwin"
      sha256 "85a2e8af41e2a18d0198f83a29a25d76244b79e8658233f6507946cab9ef383f"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.0.1/scopelet-x86_64-apple-darwin"
      sha256 "39c681499b48f3d36c41226cbe627349740d2fc5178a9a886fcf550ad37ef91d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.0.1/scopelet-aarch64-unknown-linux-gnu"
      sha256 "f3e401c2ded5e5270f3a76186c393093467b79749261ef32fa651ec874898926"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.0.1/scopelet-x86_64-unknown-linux-gnu"
      sha256 "ee32412dd43d5a4bffb216b4630266f4f4f42596ba3a7d2597612a0009c98211"
    end
  end

  def install
    binary = Dir["scopelet-*"].first

    if binary.nil?
      opoo "No scopelet binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "scopelet"
  end

  def caveats
    <<~EOS
      The binary compresses nothing on its own. Install the agent hooks with:

        scopelet install --agent all

      That copies this binary to ~/.config/scopelet/bin/scopelet and points the
      Claude Code, Codex and OpenCode hooks at the copy, so re-run it after every
      brew upgrade scopelet. Check the result with: scopelet doctor

      The model-invocable skill is a separate install:
        npx skills add maxgfr/scopelet --skill scopelet --global -a codex claude-code opencode -y
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scopelet --version")
    # Under the threshold nothing is substituted, so the bytes must come back
    # exactly. A real end-to-end run of the compressor, with no network, no model
    # call and its own cache, rather than a version string echo.
    assert_equal "hello world\n",
                 pipe_output("#{bin}/scopelet compress --cache-dir #{testpath}/cache", "hello world\n")
  end
end
