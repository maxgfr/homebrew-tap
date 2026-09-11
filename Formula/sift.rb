class Sift < Formula
  desc "Will this model fit and run fast on your machine? Answered before you download it"
  homepage "https://github.com/maxgfr/sift"
  version "v0.5.1"
  license "MIT"

  # homebrew/core ships an unrelated `sift`, a grep alternative. Both put a
  # `sift` on PATH, so Homebrew must be told rather than left to fail at link
  # time with nothing the user can act on.
  conflicts_with "sift", because: "both install a `sift` binary"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/sift/releases/download/v0.5.1/sift-macos-arm64"
      sha256 "41e018d0bfe1378b431feaa522b2d87032afe71c2b1862fb4e63c1ac94fa6fb7"
    end

    on_intel do
      url "https://github.com/maxgfr/sift/releases/download/v0.5.1/sift-macos-x64"
      sha256 "f01719bdfa1927f59c7cc4afafa59d649462574457e08289db1c6c4dae148047"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/sift/releases/download/v0.5.1/sift-linux-arm64"
      sha256 "d0011d76e1182be8be491fac8f5c30da36aff69ce8206029cd278df31bdbb615"
    end

    on_intel do
      url "https://github.com/maxgfr/sift/releases/download/v0.5.1/sift-linux-x64"
      sha256 "120e991c1f22a716a5403133a0496ebde1e165d5d837b24fe5f886282f2b650a"
    end
  end

  def install
    binary = Dir["sift-*"].first

    if binary.nil?
      opoo "No sift binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "sift"
  end

  test do
    assert_match "sift", shell_output("#{bin}/sift --help 2>&1")
    # `engines` needs no network and no model, so it is a real end-to-end check
    # rather than a version string echo.
    assert_match "known engines", shell_output("#{bin}/sift engines 2>&1")
  end
end
