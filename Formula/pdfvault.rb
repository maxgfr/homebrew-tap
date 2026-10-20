class Pdfvault < Formula
  desc "Private PDF and image tools: compress, merge, split, OCR, protect, convert"
  homepage "https://github.com/maxgfr/pdfvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.2.0/pdfvault-macos-arm64"
      sha256 "af02ba96f11dff72d39e89db53e3b9a7ca655cde4740458f377409c7866917d3"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.2.0/pdfvault-macos-x64"
      sha256 "b77360a95fbb38aaeacbb55911819a47431fcb2fa91bc737c755b84d51afa39d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.2.0/pdfvault-linux-arm64"
      sha256 "883018077587f93b6d48303689ed9678febb4a99b862c99547dca8019f2cebd7"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.2.0/pdfvault-linux-x64"
      sha256 "7b272b14a84fbdd1ba47135f2ee0884e908cf331eb371ee2dc06658f1fad9bc4"
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
