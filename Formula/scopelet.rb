class Scopelet < Formula
  desc "Compute before you send: local, recoverable evidence queries for agents"
  homepage "https://github.com/maxgfr/scopelet"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.0/scopelet-aarch64-apple-darwin"
      sha256 "5fc6dbb2109c78f9694ba7f4d97cce4963d2f58f9d1f44e620d80a81df843613"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.0/scopelet-x86_64-apple-darwin"
      sha256 "b2072e964e241f078a9254b06ac5c540fe70c8161b8cef2b42252f9cb514f338"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.0/scopelet-aarch64-unknown-linux-gnu"
      sha256 "9b209a3ce9972d809259b7ec134dfafc62d876643f857bb9eaa78767f0e57e5f"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.0/scopelet-x86_64-unknown-linux-gnu"
      sha256 "dd4466665b4fbe824c8d4d3b2a9c60bd3d9f2f2b6a62d59696e7953b83f188a8"
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
