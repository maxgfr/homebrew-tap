class Scopelet < Formula
  desc "Compute before you send: local, recoverable evidence queries for agents"
  homepage "https://github.com/maxgfr/scopelet"
  version "0.5.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.5.5/scopelet-aarch64-apple-darwin"
      sha256 "c76dcc6f27baee23b957b346bcb798adc12a30ceeaa88b3a945eaddb86a3e14c"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.5.5/scopelet-x86_64-apple-darwin"
      sha256 "00b634a9482e9a688a1621f529391de6f46eb04409d07a6b9b9323bb2dfd5de1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.5.5/scopelet-aarch64-unknown-linux-gnu"
      sha256 "2638c991ec794b3d802529ed969cb4636b4f0e969ff404b9b540270874c037c4"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.5.5/scopelet-x86_64-unknown-linux-gnu"
      sha256 "570f0d03b500166ddcfe5907d5e99d105838cdc225b63e252bb0d636b8898f12"
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
