class Pdfvault < Formula
  desc "Private PDF and image tools: compress, merge, split, OCR, protect, convert"
  homepage "https://github.com/maxgfr/pdfvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.9.0/pdfvault-macos-arm64"
      sha256 "797d242b4b5c7598b757741d1abeaddb9d4b85532f50aed59527458002b9388b"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.9.0/pdfvault-macos-x64"
      sha256 "db9a831afd8ea39b1a8671ecdbf06a47fe4bcd32627d270c212c579b5a681bf3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.9.0/pdfvault-linux-arm64"
      sha256 "7e014b3ebef77a081e1e42947bf075dc51721a6ba720897948f7b4a1f8878ed7"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.9.0/pdfvault-linux-x64"
      sha256 "54173b3cf57e4a430b908c24b8a9bee983bb04238be2aabffb8e872e650062d0"
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
