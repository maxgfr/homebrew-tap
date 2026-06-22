class PackageChecker < Formula
  desc "Flexible, lightweight shell script to detect vulnerable npm packages"
  homepage "https://github.com/maxgfr/package-checker.sh"
  url "https://github.com/maxgfr/package-checker.sh/archive/refs/tags/v1.10.164.tar.gz"
  version "v1.10.164"
  sha256 "4ef06fe82b2ba9c8a3671bdca5e4b63a7a60c63d4b2c47966acb3f39a84e654f"
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