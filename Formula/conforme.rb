class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v1.9.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.9.2/conforme-macos-arm64"
      sha256 "25911309676f0bd843ee1a85b1aaf16f6bb6efdf09329d0380f9663d3684692a"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.9.2/conforme-macos-x64"
      sha256 "61d7f731e372bb8f2298ca6a1b071c4703d2348ee833b372974d762525b811c4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.9.2/conforme-linux-arm64"
      sha256 "98609e656d4465c68bda11c8df12276ee2a335a23080c6c40a29562979231ee8"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.9.2/conforme-linux-x64"
      sha256 "f5252fafee60ae3b7d2377a4f33ffd6f63835fb08b2bc9ec4fe60bcf15e1d084"
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
