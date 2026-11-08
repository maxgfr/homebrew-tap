class Pdfvault < Formula
  desc "Compress, merge, split, OCR, protect and convert PDFs and images locally"
  homepage "https://github.com/maxgfr/pdfvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.14.1/pdfvault-macos-arm64"
      sha256 "c8985416933f7d4c2400f641ee9d34f018a8fb9d9298b1863512d61e032613bb"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.14.1/pdfvault-macos-x64"
      sha256 "a5f159822ae4ed6bb5499c95d24386c38b68380a53d1e5d3affc737e8b23ab2e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.14.1/pdfvault-linux-arm64"
      sha256 "d90f5310eec0d2e730d467e1c0f5ca576632ba098c18e9890ea494fb785f84cb"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.14.1/pdfvault-linux-x64"
      sha256 "088f32a14f1e47d4fb9732c729246d22e21db305695e56c9fe828c96c3a12794"
    end
  end

  def install
    binary = Dir["pdfvault-*"].first
    odie "No pdfvault binary found" if binary.nil?

    chmod 0755, binary
    bin.install binary => "pdfvault"
  end

  def caveats
    <<~EOS
      The agent skill installs into any coding agent (Claude Code, Codex, OpenCode, Cursor...):
        npx skills add maxgfr/pdfvault
      `pdfvault skill` prints the copy that matches this version.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/pdfvault --version").strip
    # Offline: a one-page PDF, rotated, then read back.
    (testpath/"in.pdf").write <<~PDF
      %PDF-1.4
      1 0 obj
      << /Type /Catalog /Pages 2 0 R >>
      endobj
      2 0 obj
      << /Type /Pages /Kids [3 0 R] /Count 1 >>
      endobj
      3 0 obj
      << /Type /Page /Parent 2 0 R /MediaBox [0 0 200 200] >>
      endobj
      trailer
      << /Root 1 0 R >>
      %%EOF
    PDF
    system bin/"pdfvault", "rotate", testpath/"in.pdf", "--angle", "90", "-o", testpath/"out.pdf", "--quiet"
    info = shell_output("#{bin}/pdfvault info #{testpath}/out.pdf --json")
    assert_match '"rotation": 90', info
    assert_match "name: pdfvault", shell_output("#{bin}/pdfvault skill")
  end
end
