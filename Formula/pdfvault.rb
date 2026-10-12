class Pdfvault < Formula
  desc "Private PDF and image tools: compress, merge, split, OCR, protect, convert"
  homepage "https://github.com/maxgfr/pdfvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.0.0/pdfvault-macos-arm64"
      sha256 "fb4b733e705a9ff74f61b940f396af5b5471555f0dee707f8069492a3c1308e9"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.0.0/pdfvault-macos-x64"
      sha256 "2251e140c41ad822d9601b50922559466a58ef1cc146d092d75b1e892546b299"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.0.0/pdfvault-linux-arm64"
      sha256 "604ee0bd8bbcd0df9bef091cf384c36123dbd2ec9c7811caf4b7ac43e335767d"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.0.0/pdfvault-linux-x64"
      sha256 "7d5155cf2de054b050df9c24db76f9c4f4b1b1726025840d032a6d91de296ec6"
    end
  end

  def install
    binary = Dir["pdfvault-*"].first
    odie "No pdfvault binary found" if binary.nil?

    chmod 0755, binary
    bin.install binary => "pdfvault"
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
  end
end
