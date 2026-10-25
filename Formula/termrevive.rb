class Termrevive < Formula
  desc "Save and restore terminal sessions and their running programs across reboots"
  homepage "https://github.com/maxgfr/termrevive"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/termrevive/releases/download/v1.2.0/termrevive-aarch64-apple-darwin"
      sha256 "f68a18c9b320aafdbe0a932b4067caff8b4d67e62cfaf37127878362f70e02a2"
    end

    on_intel do
      url "https://github.com/maxgfr/termrevive/releases/download/v1.2.0/termrevive-x86_64-apple-darwin"
      sha256 "44999976009b65082767e20ab0e1bf3ef2f4911d8cfcdffad70b68b2776e33a6"
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
