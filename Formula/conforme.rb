class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v2.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v2.0.0/conforme-macos-arm64"
      sha256 "c5236722be95a9c005c9c3763ad25940b1ca59f5149ba4ea24bd25aae8e69ebd"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v2.0.0/conforme-macos-x64"
      sha256 "11e8137276e4139c9d78bfa30c1dd31b7eb8c43a7c587ae41f5bd64c1e0bee9a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v2.0.0/conforme-linux-arm64"
      sha256 "e5fd809862056ceb21d29635fc80f2f68c0509b1d360a3e6998c64efa7c0f0d7"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v2.0.0/conforme-linux-x64"
      sha256 "8bf3855c485883dbab873a487a30b4ea31f1a02cd972bd36e307b719dab344ac"
    end
  end

  def install
    binary = Dir["conforme-*"].first

    if binary.nil?
      opoo "No conforme binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "conforme"
  end

  test do
    assert_match "conforme", shell_output("#{bin}/conforme --help 2>&1")
  end
end
