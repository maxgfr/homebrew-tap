class Scopelet < Formula
  desc "Compute before you send: local, recoverable evidence queries for agents"
  homepage "https://github.com/maxgfr/scopelet"
  version "1.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.1.1/scopelet-aarch64-apple-darwin"
      sha256 "9c52b15a6908501c3b37e7b5e9b9180240360fcf79d60be36de573beb3e9e82a"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.1.1/scopelet-x86_64-apple-darwin"
      sha256 "da0cba28798258d833d3a88519fda4100796184039bb9030537dcf22c962135d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.1.1/scopelet-aarch64-unknown-linux-gnu"
      sha256 "fa29767ee70c4901a47ceccee66d9ea01b0e895d0767edc3ca1b1ee83ae00426"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.1.1/scopelet-x86_64-unknown-linux-gnu"
      sha256 "6f9006781583054bd68f47635e27155ac4c356ab452d7ebd914f1c118fccd4c7"
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
