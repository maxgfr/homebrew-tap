class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v1.14.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.14.1/conforme-macos-arm64"
      sha256 "789ed5aa0b34bddcf5efa473f9a275fae7fad5e6d873310abb2965cbb0394b25"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.14.1/conforme-macos-x64"
      sha256 "744269e46e965a1d3387c24f6ad36120c7bc6e2e5595b839304ede066eff14af"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.14.1/conforme-linux-arm64"
      sha256 "55cceaa204c216b90c6f8cf39e55d514590778e4b4f53e0e8ba7d2ecd98d5849"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.14.1/conforme-linux-x64"
      sha256 "4c1ea5af23d3ab4227d9d3695e76f43b2ddeb448960690bb7f1e0abbe5a8fc97"
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
