class Scopelet < Formula
  desc "Compute before you send: local, recoverable evidence queries for agents"
  homepage "https://github.com/maxgfr/scopelet"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.3/scopelet-aarch64-apple-darwin"
      sha256 "9f5e2612049c90519bdf88e32e52c5e2bc6bb34c7c3d46b9d8e95f06416468c4"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.3/scopelet-x86_64-apple-darwin"
      sha256 "16773d8725d208ed3bcbfd0b11b09652192682a387b7795e24ed6dce020569fd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.3/scopelet-aarch64-unknown-linux-gnu"
      sha256 "60a54086a1f609560ef6dac6c63116cf2ecae16105c8fa7392d6492761581aa9"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.3/scopelet-x86_64-unknown-linux-gnu"
      sha256 "11f1e0e81dd4f7aeae314d7fb8bf5de6e2b27014b6a73864fd35aa496d741777"
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
