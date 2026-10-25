class PackageChecker < Formula
  desc "Flexible, lightweight shell script to detect vulnerable npm packages"
  homepage "https://github.com/maxgfr/package-checker.sh"
  url "https://github.com/maxgfr/package-checker.sh/archive/refs/tags/v1.14.3.tar.gz"
  sha256 "f1645b297f851e2039a78be4401c8ad9e2b86605a8eabc205f2b9a23e33780a8"
  license "MIT"

  def install
    bin.install "script.sh" => "package-checker"

    # Install data files to share/package-checker/data
    (pkgshare/"data").install Dir["data/*.purl"] if Dir.exist?("data")

    # Install documentation
    doc.install "README.md", "LICENSE", "CHANGELOG.md", "CONTRIBUTING.md"
    (doc/"docs").install Dir["docs/*.md"] if Dir.exist?("docs")
  end

  test do
    system bin/"package-checker", "--help"
  end
end
