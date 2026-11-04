class Conforme < Formula
  desc "Sync AI coding agent configuration from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.1/conforme-macos-arm64"
      sha256 "0032954bcdfad0a19f493cbd31538945123057e9981697fa58e96ebfa135b8f0"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.1/conforme-macos-x64"
      sha256 "ba59e5d23bfcc626fcf776234c0eec5fcc3314821ee5b6f8ac4ff89897f26df7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.1/conforme-linux-arm64"
      sha256 "03f9d2642e9c8c3679ae6d70463317f10db6b656e47199aaf6584b21d2b29cf3"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.1/conforme-linux-x64"
      sha256 "f1c369a72f6aa9c652669fba74a91b56052bbf7f011ec2935ff0a0c3727d74b4"
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
