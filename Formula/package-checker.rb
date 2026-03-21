class PackageChecker < Formula
  desc "Flexible, lightweight shell script to detect vulnerable npm packages"
  homepage "https://github.com/maxgfr/package-checker.sh"
  url "https://github.com/maxgfr/package-checker.sh/archive/refs/tags/v1.9.156.tar.gz"
  version "v1.9.156"
  sha256 "b9608af4fd38e38a98739869f314123678de4fa128cc21cca48cdb1f6f4a9b67"
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
    system "#{bin}/package-checker", "--help"
  end
end