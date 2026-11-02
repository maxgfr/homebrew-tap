class Verbatim < Formula
  desc "Transcribe and edit video and audio locally with Parakeet, Canary and ffmpeg"
  homepage "https://github.com/maxgfr/verbatim"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    # ONNX Runtime ships no prebuilt library for Intel Macs.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/maxgfr/verbatim/releases/download/v2.1.2/verbatim-macos-arm64"
      sha256 "a04a5abe05a724df7d89532c1ea25a8bf584c7c2737e2dcbd9e8c49f7aec3cc1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/verbatim/releases/download/v2.1.2/verbatim-linux-arm64"
      sha256 "f1f5c537668ef6e237738b8bac8151c504e2e79069dd6d09835d2682a9bd8915"
    end

    on_intel do
      url "https://github.com/maxgfr/verbatim/releases/download/v2.1.2/verbatim-linux-x64"
      sha256 "c65019dbff11c49674da8c48645e2ff01fab37ba448d8f0ca6c4907ee89e449c"
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
