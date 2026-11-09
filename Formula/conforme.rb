class Conforme < Formula
  desc "Sync AI coding agent configuration from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.2/conforme-macos-arm64"
      sha256 "18a64b42dd1f577634941ecbe14406631b2bec73bb8349de1e546eebde07e948"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.2/conforme-macos-x64"
      sha256 "b71d4f9c0a283b2b6692e04f56098c87e82120eedf75646f8ed145ddb9305606"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.2/conforme-linux-arm64"
      sha256 "608dae7b28a276abdfde0023385be740bc2eb8ac8b574457c4caac4ee08984ef"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.3.2/conforme-linux-x64"
      sha256 "d589c106027d7b9ae9186f5defbcbf9ac50f831cc7cd179968714194f0b89725"
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
