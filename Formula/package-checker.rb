class PackageChecker < Formula
  desc "Detect vulnerable npm packages with a lightweight shell script"
  homepage "https://github.com/maxgfr/package-checker.sh"
  url "https://github.com/maxgfr/package-checker.sh/archive/refs/tags/v1.16.3.tar.gz"
  sha256 "571ede082388ef1e553deb12936f60ba0673df6ed7904e811f942583d2faa18c"
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
