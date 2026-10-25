class Termrevive < Formula
  desc "Save and restore terminal sessions and their running programs across reboots"
  homepage "https://github.com/maxgfr/termrevive"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/termrevive/releases/download/v1.2.1/termrevive-aarch64-apple-darwin"
      sha256 "e7362680f1cf2bf9302136b99b5b59ff8ec7367a5a6f1c56b3f315ed1070ddb0"
    end

    on_intel do
      url "https://github.com/maxgfr/termrevive/releases/download/v1.2.1/termrevive-x86_64-apple-darwin"
      sha256 "ff990e8c29564b8fbc82d39d619833b50b87cfba9e9f37f04fba1adee870e95d"
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
      termrevive restores Ghostty, iTerm2, kitty and Terminal.app windows. Run
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
