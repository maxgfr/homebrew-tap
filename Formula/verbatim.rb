class Verbatim < Formula
  desc "Transcribe and edit video and audio locally with Parakeet, Canary and ffmpeg"
  homepage "https://github.com/maxgfr/verbatim"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    # ONNX Runtime ships no prebuilt library for Intel Macs.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/maxgfr/verbatim/releases/download/v2.1.0/verbatim-macos-arm64"
      sha256 "94a46d46bb1dc1222251ba3196e205bd5d9ad28242d79db4374e787551c3fa16"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/verbatim/releases/download/v2.1.0/verbatim-linux-arm64"
      sha256 "da7d17f26d2216678d5ca969fbf0e8297e71fdc7ed96ed2ffc5929ac78706c69"
    end

    on_intel do
      url "https://github.com/maxgfr/verbatim/releases/download/v2.1.0/verbatim-linux-x64"
      sha256 "09cabbd6a8fed3eaf59b8d3fde711da5398abfc425197e141dd1171bc60eca5c"
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
    # Offline, no model: a 6 s tone, cut by options, rendered with ffmpeg.
    system "ffmpeg", "-v", "error", "-f", "lavfi", "-i", "sine=frequency=440:duration=6", testpath/"in.m4a"
    assert_match "\"duration\"", shell_output("#{bin}/verbatim info #{testpath}/in.m4a")
    plan = shell_output("#{bin}/verbatim plan #{testpath}/in.m4a --delete-last 2 --delete 0:01-0:02 -q")
    assert_match "\"delete\"", plan
    system bin/"verbatim", "cut", testpath/"in.m4a", "--delete-first", "1", "-o", testpath/"out.m4a", "-q"
    assert_path_exists testpath/"out.m4a"
  end
end
