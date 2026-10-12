class Scopelet < Formula
  desc "Compute before you send: local, recoverable evidence queries for agents"
  homepage "https://github.com/maxgfr/scopelet"
  version "0.8.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.8.0/scopelet-aarch64-apple-darwin"
      sha256 "28b8a8de790eb025d9d517d2f83b5beaf1ad7413bdcd5bce8dbfa0c4250d659a"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.8.0/scopelet-x86_64-apple-darwin"
      sha256 "97aa7eb55e238e2622944cd014e1f54b19d6a920422663565dcc54a1b7a129bd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.8.0/scopelet-aarch64-unknown-linux-gnu"
      sha256 "e63e9190342f51584e379ff7667089ce9069223300e57ced35d2159c66321a3e"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v0.8.0/scopelet-x86_64-unknown-linux-gnu"
      sha256 "35cd7165994eb0182863959f61bf6487f14a6c7b8a40fc49b9e9d0015062ac54"
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
