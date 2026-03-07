class CopyablePdf < Formula
  desc "Convert PDF to images, OCR, and merge back to searchable PDF"
  homepage "https://github.com/maxgfr/copyable-pdf"
  url "https://github.com/maxgfr/copyable-pdf/archive/refs/tags/v1.2.2.tar.gz"
  version "v1.2.2"
  sha256 "efe47f8c29dc21ad875c80e9fbcd18f3c66274e3a17f7de51368dab36a2cda2a"
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
