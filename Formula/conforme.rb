class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v4.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v4.0.0/conforme-macos-arm64"
      sha256 "205a1e6ee0db6ebb007676027a355a057393525d0cbd2da5b1e7aebf260c81e7"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v4.0.0/conforme-macos-x64"
      sha256 "b676c6451e630c6f975e9197cd3912304242a28fd95338c8a42332453ee80fae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v4.0.0/conforme-linux-arm64"
      sha256 "89af81cf149450cc9f1687808fd7a408192b44745a575b2bd55ead004a533d69"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v4.0.0/conforme-linux-x64"
      sha256 "bb508f1389400ac6b6c8b25fdb78780600436c8d6030873a61cd8ea429a037f7"
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
