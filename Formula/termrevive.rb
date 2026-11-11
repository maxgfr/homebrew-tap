class Termrevive < Formula
  desc "Save and restore terminal sessions and their running programs across reboots"
  homepage "https://github.com/maxgfr/termrevive"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/termrevive/releases/download/v1.4.0/termrevive-aarch64-apple-darwin"
      sha256 "a33206018a37720468bcce789bfd1d8ad1b0a9751becb4a9cd2e062a52db840f"
    end

    on_intel do
      url "https://github.com/maxgfr/termrevive/releases/download/v1.4.0/termrevive-x86_64-apple-darwin"
      sha256 "3870ef074478b33edfb7eb81fb04f19e7875e9d92dc448562aae90cb2176c135"
    end
  end

  def install
    binary = Dir["termrevive-*"].first

    if binary.nil?
      opoo "No termrevive binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "termrevive"
  end

  def caveats
    <<~EOS
      termrevive restores Ghostty, iTerm2, kitty and Terminal.app windows, and
      resumes Claude Code, Codex, Mistral Vibe, opencode and Kilo sessions. Run
        termrevive doctor --fix
      once: terminals then stop reopening their own windows on top of a restore,
      and kitty gets the remote control termrevive drives it with (restart kitty).
      Agent skill: npx skills add maxgfr/termrevive
      Using its LaunchAgents? Re-run `termrevive install` after each upgrade.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/termrevive --version")
    # Offline: an empty state directory has no snapshot, and no terminal is touched.
    ENV["XDG_STATE_HOME"] = testpath/"state"
    assert_equal "no snapshot yet", shell_output("#{bin}/termrevive list").strip
    assert_match "name: termrevive", shell_output("#{bin}/termrevive skill")
  end
end
