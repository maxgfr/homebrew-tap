class Pdfvault < Formula
  desc "Private PDF and image tools: compress, merge, split, OCR, protect, convert"
  homepage "https://github.com/maxgfr/pdfvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.1.0/pdfvault-macos-arm64"
      sha256 "068c35a38c0ab32a59b24917a8f272ba04da366c9ef2da0dba9d1dc30a104af3"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.1.0/pdfvault-macos-x64"
      sha256 "bc6977b4cd9e23538aa6c913c3a3e46933e20ad7746870d8c256de5196de41b3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.1.0/pdfvault-linux-arm64"
      sha256 "c112f2a90a0c2a52486552691091bafe916cffa6249f67ea3d178207259241d4"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.1.0/pdfvault-linux-x64"
      sha256 "7e00cbf2f114ab7ba9f67da23147d67fc5b802106ec5d5aeea6c14cfb1979a4b"
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
