class Termrevive < Formula
  desc "Save and restore terminal sessions and their running programs across reboots"
  homepage "https://github.com/maxgfr/termrevive"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/termrevive/releases/download/v1.1.0/termrevive-aarch64-apple-darwin"
      sha256 "8bf150e1f4262c477b3896bf6079dab5c728b0b132ea315ec79b7a0d435721f1"
    end

    on_intel do
      url "https://github.com/maxgfr/termrevive/releases/download/v1.1.0/termrevive-x86_64-apple-darwin"
      sha256 "a7d330eddeaa348e2a87d4b7d3a9e37c65bb131c1909978246507b75b86b3432"
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
      termrevive restores Ghostty (1.3 or later) windows. Run
        termrevive doctor --fix
      once: it sets window-save-state = never, so Ghostty does not reopen its own
      windows on top of a restore. Agent skill: npx skills add maxgfr/termrevive
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
