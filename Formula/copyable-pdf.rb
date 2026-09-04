class CopyablePdf < Formula
  desc "Convert PDF to images, OCR, and merge back to searchable PDF"
  homepage "https://github.com/maxgfr/copyable-pdf"
  url "https://github.com/maxgfr/copyable-pdf/archive/refs/tags/v1.2.3.tar.gz"
  version "v1.2.3"
  sha256 "103a9cc776ea127f741f927d96a4179877a315523eb13e41176f40cdb58ac2fd"
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
