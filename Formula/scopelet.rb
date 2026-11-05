class Scopelet < Formula
  desc "Compute before you send: local, recoverable evidence queries for agents"
  homepage "https://github.com/maxgfr/scopelet"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.2/scopelet-aarch64-apple-darwin"
      sha256 "59d26d8cee4a6445d4fc4861386d967af2b0318ebee2ca3c67db321efce7e116"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.2/scopelet-x86_64-apple-darwin"
      sha256 "cfa032a3a389acb09c5d47a9ce7f293f0a8e65eab1482723080976ffb861713a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.2/scopelet-aarch64-unknown-linux-gnu"
      sha256 "3bb3947fd96bce3cd24a12e68732f54c8113eea8bcbe02e948439f3f6f92821c"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.2/scopelet-x86_64-unknown-linux-gnu"
      sha256 "69013ee613d68ec169e4985bc42cd58a193546566c551e0176d0279ad7f1bcd6"
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
