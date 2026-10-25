class CopyablePdf < Formula
  desc "Convert PDF to images, OCR, and merge back to searchable PDF"
  homepage "https://github.com/maxgfr/copyable-pdf"
  url "https://github.com/maxgfr/copyable-pdf/archive/refs/tags/v1.6.1.tar.gz"
  sha256 "711c17af642e756e13b8c657c0fdfa80011fca8a43766e46a6c66cbfb6411d05"
  license "MIT"

  # imagemagick: --clean; qpdf: --preserve; tesseract-lang: every -l language
  # beyond English; uv: --paddle, which builds PaddleOCR's environment on
  # demand. All optional to the script, but installing them here means
  # every option and language works out of the box.
  depends_on "imagemagick"
  depends_on "poppler"
  depends_on "qpdf"
  depends_on "tesseract"
  depends_on "tesseract-lang"
  depends_on "uv"

  def install
    bin.install "script.sh" => "copyable-pdf"
  end

  test do
    assert_equal "copyable-pdf #{version}", shell_output("#{bin}/copyable-pdf --version").strip
    system bin/"copyable-pdf", "--help"
  end
end
