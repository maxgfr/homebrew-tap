class PackageChecker < Formula
  desc "Flexible, lightweight shell script to detect vulnerable npm packages"
  homepage "https://github.com/maxgfr/package-checker.sh"
  url "https://github.com/maxgfr/package-checker.sh/archive/refs/tags/v1.9.160.tar.gz"
  version "v1.9.160"
  sha256 "696c1cf951935d43ac48c3490ca0d17d1b865318f2a05b0954c1b15e3d38908c"
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