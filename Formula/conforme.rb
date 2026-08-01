class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v1.11.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.11.1/conforme-macos-arm64"
      sha256 "068d00ab3a88039e4b64bedc406a11444f294026cbec37519abba0972f3b5d2f"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.11.1/conforme-macos-x64"
      sha256 "81f337c3684b725067c573883c0a4e529828038d4b147257267783b4c931e7c1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.11.1/conforme-linux-arm64"
      sha256 "7c8912a8c032f32db9b7905958454d8a81055bf067788cd6aad54bac7b10db23"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.11.1/conforme-linux-x64"
      sha256 "b728ac40c59bb320a629869aad5068635ee71250f60ac48764ae75837ce4aa19"
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
