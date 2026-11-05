class Scopelet < Formula
  desc "Compute before you send: local, recoverable evidence queries for agents"
  homepage "https://github.com/maxgfr/scopelet"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.4/scopelet-aarch64-apple-darwin"
      sha256 "4a5d2280b2b03a0bf012d3c08404f349897a69dc68af73a9fce0e0c1a8c56175"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.4/scopelet-x86_64-apple-darwin"
      sha256 "05a83921b85970d405469f824b4076baaa9be3ccb78db22eebccc196f97f3ca3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.4/scopelet-aarch64-unknown-linux-gnu"
      sha256 "4a7e2f15ed0eb4453cd9f81453aac7a053faa6def7e2d0c4c3e198dcea26b7f5"
    end

    on_intel do
      url "https://github.com/maxgfr/scopelet/releases/download/v1.2.4/scopelet-x86_64-unknown-linux-gnu"
      sha256 "2ab3dbd0218554913c67718738bc4732afb66ac9a0ebb016b2d5943706167ead"
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
