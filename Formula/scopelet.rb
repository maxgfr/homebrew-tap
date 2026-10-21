class Scopelet < Formula
  desc "Compute before you send: local, recoverable evidence queries for agents"
  homepage "https://github.com/maxgfr/scopelet"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.1.3/scopelet-aarch64-apple-darwin"
      sha256 "051fb0ab290140a23509684aa5727231acef5169483693f0b3ec9f00c998efd3"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.1.3/scopelet-x86_64-apple-darwin"
      sha256 "cf37ffc211caab7089b494b0e1eff219c847a03c39eaa57d9669046c81443030"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.1.3/scopelet-aarch64-unknown-linux-gnu"
      sha256 "254ed056c69aef4dbe620844f6374f1182be6a92ea747b86fbfa14b1bb149761"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.1.3/scopelet-x86_64-unknown-linux-gnu"
      sha256 "11b17273909b845e87bacfc107e513ee40fedd9959e43d618314910ffda4ae50"
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
