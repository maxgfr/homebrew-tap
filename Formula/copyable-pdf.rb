class CopyablePdf < Formula
  desc "Convert PDF to images, OCR, and merge back to searchable PDF"
  homepage "https://github.com/maxgfr/copyable-pdf"
  url "https://github.com/maxgfr/copyable-pdf/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "0cbdf788e0c532479103a37938725b1179aa1097446eb0d295b0616bdf6ae45b"
  license "MIT"

  # imagemagick: --clean; qpdf: --preserve. Both are optional to the script,
  # but installing them here means every option works out of the box.
  depends_on "imagemagick"
  depends_on "poppler"
  depends_on "qpdf"
  depends_on "tesseract"

  def install
    bin.install "script.sh" => "copyable-pdf"
  end

  def caveats
    <<~EOS
      Only English is installed with tesseract. For other languages (e.g. -l fra):
        brew install tesseract-lang
    EOS
  end

  test do
    assert_equal "copyable-pdf #{version}", shell_output("#{bin}/copyable-pdf --version").strip
    system bin/"copyable-pdf", "--help"
  end
end
