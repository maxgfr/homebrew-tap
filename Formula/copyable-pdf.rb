class CopyablePdf < Formula
  desc "Convert PDF to images, OCR, and merge back to searchable PDF"
  homepage "https://github.com/maxgfr/copyable-pdf"
  url "https://github.com/maxgfr/copyable-pdf/archive/refs/tags/v1.2.1.tar.gz"
  version "v1.2.1"
  sha256 "7ae6d61e7d7c92eabfbd22cd4e0879eafdcb478dd60805e7505b560873447613"
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
