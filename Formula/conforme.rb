class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v5.2.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.2.3/conforme-macos-arm64"
      sha256 "bf0c81566379f32ac74b778ebffe8670401e118569d2f4caaa39e38ab1d2df8f"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.2.3/conforme-macos-x64"
      sha256 "0024ce2d0cb201b1714df36e922fe75476091710998792a85a810793869c7492"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.2.3/conforme-linux-arm64"
      sha256 "74c8121517f15a273e2ad4398cfb24d9d6fa4a0446b2b7e27d33d7c983b1db39"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.2.3/conforme-linux-x64"
      sha256 "231fa446b9b4ff6f2f0b4e08cbcb6a7a9ef5a0ce82060c88598c5ad4951eab81"
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
