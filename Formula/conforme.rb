class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v5.2.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.2.2/conforme-macos-arm64"
      sha256 "a9591d0da15e484ee87dac052b4dcd23c68a36587531b7660bab8d3862a65024"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.2.2/conforme-macos-x64"
      sha256 "0a12af8a8580e5618653a544d4da172500c3f277cc6330f87894005e0f75bf1c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.2.2/conforme-linux-arm64"
      sha256 "775c4c4b79e8028486a8f375b44e354ff56833746f55c7069327abcb4e6e9d0c"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.2.2/conforme-linux-x64"
      sha256 "a907c037a19e7e47aacf7f886b90d1fce378cc3268cd55b452b7aa1129a226fa"
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
