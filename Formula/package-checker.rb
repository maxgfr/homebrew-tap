class PackageChecker < Formula
  desc "Flexible, lightweight shell script to detect vulnerable npm packages"
  homepage "https://github.com/maxgfr/package-checker.sh"
  url "https://github.com/maxgfr/package-checker.sh/archive/refs/tags/v1.9.102.tar.gz"
  version "v1.9.102"
  sha256 "8cb58e1d79a203b8a51380181d780801a03602ceae68d3d135faaf3f3b31d3b1"
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