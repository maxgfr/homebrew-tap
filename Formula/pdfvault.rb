class Pdfvault < Formula
  desc "Private PDF and image tools: compress, merge, split, OCR, protect, convert"
  homepage "https://github.com/maxgfr/pdfvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.3.1/pdfvault-macos-arm64"
      sha256 "7362c16c08b8ff6dea8a8fc3cc707401b0efeade36439c8881c84f31c5ddaad9"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.3.1/pdfvault-macos-x64"
      sha256 "7a20415d45cd504c74655306dfb5d8f636964294dd22b29597bff82fda550233"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.3.1/pdfvault-linux-arm64"
      sha256 "f923232b65bdc0d0f5689afc085a3d33edf07868cfe0a1eb67bf6119d366f413"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.3.1/pdfvault-linux-x64"
      sha256 "d7b40b0f0f896c24c33c2247b0065260166731001f859ab29389389d30f1f3e1"
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
