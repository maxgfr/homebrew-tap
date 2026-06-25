class Codexfeine < Formula
  desc "Run OpenAI Codex caffeinated so your machine stays awake during the session"
  homepage "https://github.com/maxgfr/claudfeine"
  url "https://github.com/maxgfr/claudfeine/archive/refs/tags/v1.0.1.tar.gz"
  version "v1.0.1"
  sha256 "275922577394f392d1dd0efbe545321a9fdb127bc6a8e3094ca17b8c3c7a6a93"
  license "MIT"

  def install
    bin.install "claudfeine" => "codexfeine"
    doc.install "README.md", "LICENSE", "CHANGELOG.md", "CONTRIBUTING.md"
  end

  test do
    assert_match "codexfeine", shell_output("#{bin}/codexfeine --feine-version")
  end
end
