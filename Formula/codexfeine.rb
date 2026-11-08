class Codexfeine < Formula
  desc "Keep your machine awake for the duration of an OpenAI Codex session"
  homepage "https://github.com/maxgfr/claudfeine"
  url "https://github.com/maxgfr/claudfeine/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "c262e460a1de3efe7289af053823f7f3d9ec7f1415b03615d6b6eaffa62f955b"
  license "MIT"

  def install
    bin.install "claudfeine" => "codexfeine"
    doc.install "README.md", "LICENSE", "CHANGELOG.md", "CONTRIBUTING.md"
  end

  test do
    assert_match "codexfeine", shell_output("#{bin}/codexfeine --feine-version")
  end
end
