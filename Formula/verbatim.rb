class Verbatim < Formula
  desc "Transcribe and edit video and audio locally with Parakeet, ffmpeg and AI"
  homepage "https://github.com/maxgfr/verbatim"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    # ONNX Runtime ships no prebuilt library for Intel Macs.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/maxgfr/verbatim/releases/download/v1.0.1/verbatim-macos-arm64"
      sha256 "092e876fcf72830a12def23a7f01ccdcd180ae028e0c7afe5f18021d7fc963fa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/verbatim/releases/download/v1.0.1/verbatim-linux-arm64"
      sha256 "9884554ce90e0891fe34425602664295ff7bba7042ae863eeeb90dbcfa379805"
    end

    on_intel do
      url "https://github.com/maxgfr/verbatim/releases/download/v1.0.1/verbatim-linux-x64"
      sha256 "3d4df2932dd4d5b8323c1a5f526921f88ef59c0bfff47c4343fa4326f89f29c3"
    end
  end

  def install
    binary = Dir["verbatim-*"].first
    odie "No verbatim binary found" if binary.nil?

    chmod 0755, binary
    bin.install binary => "verbatim"
  end

  def caveats
    <<~EOS
      The first transcription downloads NVIDIA Parakeet TDT 0.6B v3 once (~670 MB):
        verbatim model download
      The agent skill installs into any coding agent (Claude Code, Codex, OpenCode, Cursor...):
        npx skills add maxgfr/verbatim
      `verbatim skill` prints the copy that matches this version.
    EOS
  end

  test do
    assert_equal "verbatim #{version}", shell_output("#{bin}/verbatim --version").strip
    assert_match "name: verbatim", shell_output("#{bin}/verbatim skill")
    # Offline, no model: a 6 s clip, a plain-French cut planned, then rendered with ffmpeg.
    system "ffmpeg", "-v", "error", "-f", "lavfi", "-i", "sine=frequency=440:duration=6", testpath/"in.m4a"
    plan = shell_output("#{bin}/verbatim plan #{testpath}/in.m4a 'supprime les 2 dernières secondes' -q")
    assert_match "\"delete\"", plan
    system bin/"verbatim", "cut", testpath/"in.m4a", "--delete", "0:01-0:02", "-o", testpath/"out.m4a", "-q"
    assert_path_exists testpath/"out.m4a"
  end
end
