class Scopelet < Formula
  desc "Replace oversized agent command output with local, recoverable bounded views"
  homepage "https://github.com/maxgfr/scopelet"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.5/scopelet-aarch64-apple-darwin"
      sha256 "d3109dbaa880ea68995e5caa02939b54ebe72d634f3635b202db034f06846975"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.5/scopelet-x86_64-apple-darwin"
      sha256 "6062a44e60f1bf02089ecc3d36c590b3cfceaa8c669c7d46b9572985e18613fb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.5/scopelet-aarch64-unknown-linux-gnu"
      sha256 "9b316b0f290be1ecaa438d2216aeda4b3fe738be18c613ba587a170cd60cd6ee"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.5/scopelet-x86_64-unknown-linux-gnu"
      sha256 "18d632a4ce8a0f105105ff0dc0f1907b95b1e6efa74276a83b1703ec25fdf1ff"
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
