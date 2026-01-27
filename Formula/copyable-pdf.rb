class CopyablePdf < Formula
  desc "Convert PDF to images, OCR, and merge back to searchable PDF"
  homepage "https://github.com/maxgfr/copyable-pdf"
  url "https://github.com/maxgfr/copyable-pdf/archive/refs/tags/v0.0.0.tar.gz"
  version "v0.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
