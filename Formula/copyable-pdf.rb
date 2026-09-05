class CopyablePdf < Formula
  desc "Convert PDF to images, OCR, and merge back to searchable PDF"
  homepage "https://github.com/maxgfr/copyable-pdf"
  url "https://github.com/maxgfr/copyable-pdf/archive/refs/tags/v1.3.0.tar.gz"
  version "v1.3.0"
  sha256 "2f20700a963d3b776822c73a8e1b31411ce85d199bff1eab5e5e42dc73e3f240"
  license "MIT"

  depends_on "poppler"
  depends_on "qpdf"
  depends_on "tesseract"

  def install
    bin.install "script.sh" => "copyable-pdf"
  end

  test do
    system "#{bin}/copyable-pdf", "--help"
  end
end
