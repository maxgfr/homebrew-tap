class Scopelet < Formula
  desc "Compute before you send: local, recoverable evidence queries for agents"
  homepage "https://github.com/maxgfr/scopelet"
  version "0.7.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.7.2/scopelet-aarch64-apple-darwin"
      sha256 "b9e7e961d218e8c3a329c1ee6a59aa4ad4643de3132362f9a78a6a2b458a58fa"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.7.2/scopelet-x86_64-apple-darwin"
      sha256 "fef899093f9baefef2773312d99c792f56c9fb023f4573a77b955b2ec6d24ede"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.7.2/scopelet-aarch64-unknown-linux-gnu"
      sha256 "bce6cbb7cd8956d7000d41960c3419bb76f936f8212978433805330a2b9fc685"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.7.2/scopelet-x86_64-unknown-linux-gnu"
      sha256 "9883c415d158c42c13ac71bdcab04e21d4ae1072acf2a4be7952f5f81a006620"
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
