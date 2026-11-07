class PackageChecker < Formula
  desc "Flexible, lightweight shell script to detect vulnerable npm packages"
  homepage "https://github.com/maxgfr/package-checker.sh"
  url "https://github.com/maxgfr/package-checker.sh/archive/refs/tags/v1.15.20.tar.gz"
  sha256 "c7bcd29aa867464bde8c9d6856465cb67629342eb34924efd38257573c6785d0"
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
