class Codexfeine < Formula
  desc "Run OpenAI Codex caffeinated so your machine stays awake during the session"
  homepage "https://github.com/maxgfr/claudfeine"
  url "https://github.com/maxgfr/claudfeine/archive/refs/tags/v1.0.0.tar.gz"
  version "v1.0.0"
  sha256 "0a3001304ed6c7ef0740d275bde1b7faa46e78a3e6b3de1fc629100a3440b4dd"
  license "MIT"

  def install
    bin.install "claudfeine" => "codexfeine"
    doc.install "README.md", "LICENSE", "CHANGELOG.md", "CONTRIBUTING.md"
  end

  test do
    assert_match "codexfeine", shell_output("#{bin}/codexfeine --feine-version")
  end
end
