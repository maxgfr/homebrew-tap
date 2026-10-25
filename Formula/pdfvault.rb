class Pdfvault < Formula
  desc "Private PDF and image tools: compress, merge, split, OCR, protect, convert"
  homepage "https://github.com/maxgfr/pdfvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.8.0/pdfvault-macos-arm64"
      sha256 "4f453bdd090a6236a732add024813901e164734af8ba22917421525e98d34c20"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.8.0/pdfvault-macos-x64"
      sha256 "6ca006af6af1fe7684e4512761ddefedf70c9e87d8c1054cfb16cf0e0e3891fd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.8.0/pdfvault-linux-arm64"
      sha256 "5a3dd1bd51623bacbda65d76f28f12e2fe1ff80ba9ff1a2e2bfc20aea3584811"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.8.0/pdfvault-linux-x64"
      sha256 "5204ce32cd369c5704e85d97576b79dc7d449ded46fbcdb3fb52ff40c998f995"
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
