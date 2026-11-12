class Scopelet < Formula
  desc "Replace oversized agent command output with local, recoverable bounded views"
  homepage "https://github.com/maxgfr/scopelet"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.12/scopelet-aarch64-apple-darwin"
      sha256 "a06e0fc21b460ad022643e07701700d04d1e33fc3553990d50806c021b989a78"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.12/scopelet-x86_64-apple-darwin"
      sha256 "5c3b099424cb3649c664c79d3e3ad81291a28c7048f673aaadc312c533b0032e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.12/scopelet-aarch64-unknown-linux-gnu"
      sha256 "5c7af159cd4389c0a43c5e99f0297daedce87c5887f3867d9478947c625117b4"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.12/scopelet-x86_64-unknown-linux-gnu"
      sha256 "4e927fb7626e0ebaab1e54522a809977c939d2da5e2ebdcb351b77f26cbfa649"
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
