class Conforme < Formula
  desc "Sync AI coding agent configuration from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.3/conforme-macos-arm64"
      sha256 "e9c157358e37c05f509713a382d0a69dcf9091eaa0ab90a4698b7c188ae6b4a2"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.3/conforme-macos-x64"
      sha256 "52d663f9ec2944e98582056e3d0d068b00e090d48c503fd98fb19f22ee351bd6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.3/conforme-linux-arm64"
      sha256 "bfd7dc5d0e3e412efcbd32241e5952e54e359c4b985024fd7fcb658e548be956"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.3/conforme-linux-x64"
      sha256 "2348c13b41a683d09318c29dcc712224530869cc80aa47caf0097c189152ca3b"
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
