class Pdfvault < Formula
  desc "Private PDF and image tools: compress, merge, split, OCR, protect, convert"
  homepage "https://github.com/maxgfr/pdfvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.10.0/pdfvault-macos-arm64"
      sha256 "8b4f69b8ebe5e969defdcccd41d52e80ed2b2948890b32a1f0c720f46252500b"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.10.0/pdfvault-macos-x64"
      sha256 "a8aee8d884b22454e150fdabe6a20bf1b57fbb27bb05277a4913df6107aa8e6d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.10.0/pdfvault-linux-arm64"
      sha256 "351cf01a43fd270ba02be4624144c59cc9abec637e6d8a6d857a4dfb1bb19a71"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.10.0/pdfvault-linux-x64"
      sha256 "ecaf3a0a0ab763302291ed570545dcccec83ba4a66064ced3f0e4707a6f52ac4"
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
