class Pdfvault < Formula
  desc "Private PDF and image tools: compress, merge, split, OCR, protect, convert"
  homepage "https://github.com/maxgfr/pdfvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.13.2/pdfvault-macos-arm64"
      sha256 "95fb91dec306a067dabe04ac3cc427f652727a8e147681d97e60bf1b1df908fb"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.13.2/pdfvault-macos-x64"
      sha256 "e6eeb81a8db31229836eacab3d3d72eb1e30ae8da683fce398630bb4ff70c00b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.13.2/pdfvault-linux-arm64"
      sha256 "46093d2e0f967da3ae72eced7b2a6d963fbc89e0abfbd3af3a9e74873aff1885"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.13.2/pdfvault-linux-x64"
      sha256 "a1a7fdcfc14a4e08e6139e601e1f89ec7e597d8ce524f30ae2320f16f6e7e3ac"
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
