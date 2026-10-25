class Termrevive < Formula
  desc "Save and restore terminal sessions and their running programs across reboots"
  homepage "https://github.com/maxgfr/termrevive"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/termrevive/releases/download/v1.0.0/termrevive-aarch64-apple-darwin"
      sha256 "810d2f914d4815971785a709629439d9538aefd9b109e0d968b9ecf90b410485"
    end

    on_intel do
      url "https://github.com/maxgfr/termrevive/releases/download/v1.0.0/termrevive-x86_64-apple-darwin"
      sha256 "47a20f1e5038e318bd24c5af6c79eff7fde2462a34aa35f594192ff9cf585df0"
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
      termrevive restores Ghostty (1.3 or later) windows. Add
        window-save-state = never
      to ~/.config/ghostty/config so Ghostty does not reopen its own windows on top
      of a restore, then check the setup with `termrevive doctor`.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/termrevive --version")
    # Offline: an empty state directory has no snapshot, and no terminal is touched.
    ENV["XDG_STATE_HOME"] = testpath/"state"
    assert_equal "no snapshot yet", shell_output("#{bin}/termrevive list").strip
  end
end
