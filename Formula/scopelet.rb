class Scopelet < Formula
  desc "Compute before you send: local, recoverable evidence queries for agents"
  homepage "https://github.com/maxgfr/scopelet"
  version "0.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.7.0/scopelet-aarch64-apple-darwin"
      sha256 "10117cb70b4857fa53220a15bf84771d25c1e330ac9b1c250b249aa2135f7bbe"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.7.0/scopelet-x86_64-apple-darwin"
      sha256 "cfac219418a2c90d1b6a4edcc6b0e4310de3d3b59847981b0f11f431f0b95e40"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.7.0/scopelet-aarch64-unknown-linux-gnu"
      sha256 "cccf025af9c36c9c97b4ceddaaecb9e6f863379dc1a1ca4d36bc80fd1b98beab"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.7.0/scopelet-x86_64-unknown-linux-gnu"
      sha256 "eff5168cffef4e8e0c5daf0ea830c00824dd4d1c9497733e015ad2ce882b06e6"
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
