class CopyablePdf < Formula
  desc "Convert PDF to images, OCR, and merge back to searchable PDF"
  homepage "https://github.com/maxgfr/copyable-pdf"
  url "https://github.com/maxgfr/copyable-pdf/archive/refs/tags/v1.0.1.tar.gz"
  version "v1.0.1"
  sha256 "293f9a32df1cf2741c63ddceefa53b39ee0e39f57c365ef4c884edad6c8a6a79"
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
