class Pdfvault < Formula
  desc "Private PDF and image tools: compress, merge, split, OCR, protect, convert"
  homepage "https://github.com/maxgfr/pdfvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.3.0/pdfvault-macos-arm64"
      sha256 "bada695fd09fb4e6436a5f25d11efd14353cf9cd9aef9128c5f8b0f946e19f93"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.3.0/pdfvault-macos-x64"
      sha256 "b92dfc17a03d8cc002294551c709e59594c98dacd64509584a84a7eb0c363b61"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.3.0/pdfvault-linux-arm64"
      sha256 "65afd38654830f301b9e7e60dbc98404b40faff1c56296935112fb1171f5e7d8"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.3.0/pdfvault-linux-x64"
      sha256 "f70979343b3a602563fdba25bceea904f89d159215800732c7805550e7e6e301"
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
