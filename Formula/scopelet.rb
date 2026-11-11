class Scopelet < Formula
  desc "Replace oversized agent command output with local, recoverable bounded views"
  homepage "https://github.com/maxgfr/scopelet"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.6/scopelet-aarch64-apple-darwin"
      sha256 "ad1fe0a9c7fbf119e74873fb18a21972db938c598fbe69cdc575da3fccbd1f00"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.6/scopelet-x86_64-apple-darwin"
      sha256 "ff68d375ab0ba3f76ea914adb8c9f5f90825b3f6420333f0f3dc6452f5dd599c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.6/scopelet-aarch64-unknown-linux-gnu"
      sha256 "374a362c427d4a1d810e381bb8579b99e8a02c11b3d3bf2b8d6cce62a41b174b"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.6/scopelet-x86_64-unknown-linux-gnu"
      sha256 "b71b44a6e9dab72b0317b046e3da7dbd860cadc8950b36f2b1077751e2dcd216"
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
