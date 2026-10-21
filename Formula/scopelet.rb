class Scopelet < Formula
  desc "Compute before you send: local, recoverable evidence queries for agents"
  homepage "https://github.com/maxgfr/scopelet"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.1.2/scopelet-aarch64-apple-darwin"
      sha256 "ce1ed5470079e4ed87af58e8df965284c0f3f062d2438b8a03d15d1f815292eb"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.1.2/scopelet-x86_64-apple-darwin"
      sha256 "4c3e3d07ec8ef39dd1795af660252b60cdf444a7e9d9eae7b41391af2f7c03d1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.1.2/scopelet-aarch64-unknown-linux-gnu"
      sha256 "c5838da33a428e50050b6d8345c97e361e3e068f4501029df0b3c94d43a9e17c"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.1.2/scopelet-x86_64-unknown-linux-gnu"
      sha256 "9351f05826fc3fe1439eecaf00d59848d5d0c6f09e50fe3aecfefcd07bb802a4"
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
