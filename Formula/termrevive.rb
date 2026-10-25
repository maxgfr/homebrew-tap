class Termrevive < Formula
  desc "Save and restore terminal sessions and their running programs across reboots"
  homepage "https://github.com/maxgfr/termrevive"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/termrevive/releases/download/v1.0.2/termrevive-aarch64-apple-darwin"
      sha256 "edc741278fa42e0de440b192d2d6900218fe60ee952e25fc9cb1ae2b529e35fc"
    end

    on_intel do
      url "https://github.com/maxgfr/termrevive/releases/download/v1.0.2/termrevive-x86_64-apple-darwin"
      sha256 "3a83d10bd73bd169b804a5ef9123839391136a12553b12b28af788e78598721b"
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
