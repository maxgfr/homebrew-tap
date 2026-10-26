class CopyablePdf < Formula
  desc "Convert PDF to images, OCR, and merge back to searchable PDF"
  homepage "https://github.com/maxgfr/copyable-pdf"
  url "https://github.com/maxgfr/copyable-pdf/archive/refs/tags/v3.0.1.tar.gz"
  sha256 "f71756d9ae890f6b216584fbb4719f6552658741cd22318d51860ac4311c412b"
  license "MIT"

  # uv builds the OCR engine (PaddleOCR's models via RapidOCR); qpdf is for
  # --preserve.
  depends_on "poppler"
  depends_on "qpdf"
  depends_on "uv"

  def install
    libexec.install "script.sh" => "copyable-pdf"
    # The OCR engine lives in the prefix, not in each user's ~/.cache, so
    # post_install can put it there and every run finds it.
    (bin/"copyable-pdf").write_env_script libexec/"copyable-pdf",
                                          COPYABLE_PDF_HOME: var/"copyable-pdf"
  end

  # Install the OCR engine and fetch its models now, so the first run starts
  # straight away. If this cannot run (no network), the first run does it.
  post_install_steps do
    run "copyable-pdf", base: :bin, args: ["--install-engine"],
        writable_paths: ["copyable-pdf"], writable_base: :var,
        network_access: true, must_succeed: false
  end

  test do
    assert_equal "copyable-pdf #{version}", shell_output("#{bin}/copyable-pdf --version").strip
    system bin/"copyable-pdf", "--help"
  end
end
