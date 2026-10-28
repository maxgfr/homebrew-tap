class Pdfvault < Formula
  desc "Private PDF and image tools: compress, merge, split, OCR, protect, convert"
  homepage "https://github.com/maxgfr/pdfvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.11.0/pdfvault-macos-arm64"
      sha256 "09e372f352a33c2a57d9690b8a16862341ba76e13e945e39fd77a53bbad9cd04"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.11.0/pdfvault-macos-x64"
      sha256 "49e1326d997411bae7820054454a6ef3ecc30d99649bf536823975cf064f47e3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.11.0/pdfvault-linux-arm64"
      sha256 "ef215c4f6cf4282852bc42acacf8a27532887e42154cccc592b6c7634df3a9ed"
    end

    on_intel do
      url "https://github.com/maxgfr/pdfvault/releases/download/v1.11.0/pdfvault-linux-x64"
      sha256 "d3476a5c65b8d1803a3da7239b8b221565282a4380b6d6013a8f70db81e5e88d"
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
