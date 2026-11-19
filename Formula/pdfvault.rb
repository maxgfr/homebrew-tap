class Pdfvault < Formula
  desc "Compress, merge, split, OCR, protect and convert PDFs and images locally"
  homepage "https://github.com/maxgfr/pdfvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.15.0/pdfvault-macos-arm64"
      sha256 "37922e36748bd19ea807f373de48e3cd4fabc80fd879ae6465ee30d994970557"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.15.0/pdfvault-macos-x64"
      sha256 "d6616e70b59285f3f8b1a3f67c7e8f7a19af0ec028f6eff1bad99e6ebf8caa67"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.15.0/pdfvault-linux-arm64"
      sha256 "ecee066866e5e622c7197d55ff2976e8377fa011841af50b76dac0b503857ee7"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.15.0/pdfvault-linux-x64"
      sha256 "543ac6c24e305e1a819ff24352cf2a3cc06c6eadfb44687fa76a882d42fab9ca"
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
