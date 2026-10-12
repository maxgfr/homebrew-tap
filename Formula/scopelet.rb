class Scopelet < Formula
  desc "Compute before you send: local, recoverable evidence queries for agents"
  homepage "https://github.com/maxgfr/scopelet"
  version "0.9.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.9.0/scopelet-aarch64-apple-darwin"
      sha256 "77af5d22d54eb06ede1a1f578b2af43a76e4e1d472acd49296487013bc4906f5"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.9.0/scopelet-x86_64-apple-darwin"
      sha256 "75848b536f4ccbe596dc39f067035d56aadbcea9cb0f87b8dfb93e348fa26c0a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.9.0/scopelet-aarch64-unknown-linux-gnu"
      sha256 "1f8596192a5ff177e0b31c0365f46a513993e0bd635545efa4e234aa51a601f2"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.9.0/scopelet-x86_64-unknown-linux-gnu"
      sha256 "e1324ab01add99f1ad1a62e025d86899caf7b48d4b30f702ddac333e7e69397f"
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
