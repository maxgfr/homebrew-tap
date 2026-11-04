class PackageChecker < Formula
  desc "Flexible, lightweight shell script to detect vulnerable npm packages"
  homepage "https://github.com/maxgfr/package-checker.sh"
  url "https://github.com/maxgfr/package-checker.sh/archive/refs/tags/v1.15.14.tar.gz"
  sha256 "a5d02f3044ff1521dfff6a21b0cc139e17ad7e707ac22bcfcaee0029f10a70c6"
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
