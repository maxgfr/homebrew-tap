class CopyablePdf < Formula
  desc "Convert PDF to images, OCR, and merge back to searchable PDF"
  homepage "https://github.com/maxgfr/copyable-pdf"
  url "https://github.com/maxgfr/copyable-pdf/archive/refs/tags/v1.1.0.tar.gz"
  version "v1.1.0"
  sha256 "988587b50812e03c576bf5615ed9152e26f389a5c47d77d0876c6d6c21451939"
  license "MIT"

  depends_on "tesseract"
  depends_on "poppler"

  def install
    bin.install "script.sh" => "copyable-pdf"
  end

  test do
    system "#{bin}/copyable-pdf", "--help"
  end
end
