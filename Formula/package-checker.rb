class PackageChecker < Formula
  desc "Flexible, lightweight shell script to detect vulnerable npm packages"
  homepage "https://github.com/maxgfr/package-checker.sh"
  url "https://github.com/maxgfr/package-checker.sh/archive/refs/tags/v1.6.12.tar.gz"
  version "v1.6.12"
  sha256 "cd0b40c029ec4f964cbdac3502dcc1cc61de71e803aaa26d0299a8506fd9bd69"
  license "MIT"

  def install
    bin.install "script.sh" => "package-checker"
    
    # Install data files
    (prefix/"data").install Dir["data/*.purl"] if Dir.exist?("data")
    
    # Install documentation
    doc.install "README.md", "LICENSE", "CHANGELOG.md", "CONTRIBUTING.md"
    (doc/"docs").install Dir["docs/*.md"] if Dir.exist?("docs")
  end

  test do
    system "#{bin}/package-checker", "--help"
  end
end