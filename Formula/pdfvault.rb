class Pdfvault < Formula
  desc "Private PDF and image tools: compress, merge, split, OCR, protect, convert"
  homepage "https://github.com/maxgfr/pdfvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.14.0/pdfvault-macos-arm64"
      sha256 "920a87e202765466ecce80d28ed77b203de33973c4c831f033f0d03f552ca83c"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.14.0/pdfvault-macos-x64"
      sha256 "d76846f9cf6e88a7462ef278d7085bee9391082b3a8125b7cb010379a36a3a6c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.14.0/pdfvault-linux-arm64"
      sha256 "fe5f7eb4313d9a36273a63e7315c8df5558ab71d5186afc7baed7394472dcf1d"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.14.0/pdfvault-linux-x64"
      sha256 "19f9ff875508ad55312c14417aa7acf4752f230e88625739a5e5fa672cc8dbf1"
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
