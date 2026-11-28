class Scopelet < Formula
  desc "Replace oversized agent command output with local, recoverable bounded views"
  homepage "https://github.com/maxgfr/scopelet"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.13/scopelet-aarch64-apple-darwin"
      sha256 "4c61d2a7bf50a32cdfbfc621aa0a289d6673aa92bc111d7d293b1e607b1251a7"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.13/scopelet-x86_64-apple-darwin"
      sha256 "6b36ebd0a689e1724d4a2b8188e1dbb9c597f4b38dfd3ca9753b44b31f2010f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.13/scopelet-aarch64-unknown-linux-gnu"
      sha256 "a46c4bb57721d750d98085f854bf48fad9ff2f937f0fffb9a142e65cbb991f2a"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.13/scopelet-x86_64-unknown-linux-gnu"
      sha256 "4c2afca3f2cc6970e7098cf32c516154a492cff126c1695a808a0836bcbcc4bb"
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
