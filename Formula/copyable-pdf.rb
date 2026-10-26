class CopyablePdf < Formula
  desc "Convert PDF to images, OCR, and merge back to searchable PDF"
  homepage "https://github.com/maxgfr/copyable-pdf"
  url "https://github.com/maxgfr/copyable-pdf/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "a8626f67a6f579ee5ae41222a1e256eb9139fbed460bcf81495bd6bdfa62b668"
  license "MIT"

  # uv: builds the default OCR engine (PaddleOCR's models via RapidOCR).
  # tesseract, tesseract-lang: --tesseract, in every language. qpdf: --preserve.
  # imagemagick: --clean. Installing them all means every option works.
  depends_on "imagemagick"
  depends_on "poppler"
  depends_on "qpdf"
  depends_on "tesseract"
  depends_on "tesseract-lang"
  depends_on "uv"

  def install
    libexec.install "script.sh" => "copyable-pdf"
    # The OCR engine lives in the prefix, not in each user's ~/.cache, so
    # post_install can put it there and every run finds it.
    (bin/"copyable-pdf").write_env_script libexec/"copyable-pdf",
                                          COPYABLE_PDF_HOME: var/"copyable-pdf"
  end

  def post_install
    # Install the OCR engine and fetch its models now, so the first run starts
    # straight away. If this cannot run (no network), the first run does it.
    system bin/"copyable-pdf", "--install-engine"
  end

  test do
    assert_equal "copyable-pdf #{version}", shell_output("#{bin}/copyable-pdf --version").strip
    system bin/"copyable-pdf", "--help"
  end
end
