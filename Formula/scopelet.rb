class Scopelet < Formula
  desc "Compute before you send: local, recoverable evidence queries for agents"
  homepage "https://github.com/maxgfr/scopelet"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.1/scopelet-aarch64-apple-darwin"
      sha256 "198a725e1f10f8f15c19931aa9d2c30fa34914197b01242dee7801b048bb5a2b"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.1/scopelet-x86_64-apple-darwin"
      sha256 "9bb3186c7115473c40b44f1410b98d8d3bb6e39200cbfe3d4f14b8cee9621e46"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.1/scopelet-aarch64-unknown-linux-gnu"
      sha256 "118c995413d7597f2c3af11196940e80499680357d8ef705004de76ac25d0866"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.1/scopelet-x86_64-unknown-linux-gnu"
      sha256 "919992e688678c39f61f87a754ab6a2ff6223808faeb8150bb7c7c6856db0bec"
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
