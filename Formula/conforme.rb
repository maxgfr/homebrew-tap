class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v1.9.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.9.3/conforme-macos-arm64"
      sha256 "e3c997c12fdbeec6a3f3367339710dfb85544652dc786d75304f803d79039af7"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.9.3/conforme-macos-x64"
      sha256 "4c5fef4c23c6bbb77cdaee1322c7cc3d14998400848a0cd19c9d77e205ddd368"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.9.3/conforme-linux-arm64"
      sha256 "ea60c14003c63f70c80f9e3374bd8a9d1b57b9714b0f6cdcf760244030d22e48"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.9.3/conforme-linux-x64"
      sha256 "36e16b38274117c83f0c4ca92f21fd35593a4ec2e9d44af11aec38d954ead3a8"
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
