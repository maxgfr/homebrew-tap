class Conforme < Formula
  desc "Sync AI coding agent configuration from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.0/conforme-macos-arm64"
      sha256 "113cb77f00469ea85d45f1a105919d1f61ac837c9bd10b3053072bce286036e9"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.0/conforme-macos-x64"
      sha256 "756d1f091f96363d810647a160f4e6d89d2666e7af3ef3050fce5ed79ffe3628"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.0/conforme-linux-arm64"
      sha256 "4fc313addeef454dca6701ad7975fdb61540796ce3e4ba50a983f6f2bc06937b"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.0/conforme-linux-x64"
      sha256 "e7c7158a91a46a673e0e42790a82e0dd40f02a3030f0ad4078e8b297028b8362"
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
