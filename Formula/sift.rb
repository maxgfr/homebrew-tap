class Sift < Formula
  desc "Will this model fit and run fast on your machine? Answered before you download it"
  homepage "https://github.com/maxgfr/sift"
  version "v0.7.0"
  license "MIT"

  # homebrew/core ships an unrelated `sift`, a grep alternative. Both put a
  # `sift` on PATH, so Homebrew must be told rather than left to fail at link
  # time with nothing the user can act on.
  conflicts_with "sift", because: "both install a `sift` binary"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/sift/releases/download/v0.7.0/sift-macos-arm64"
      sha256 "f73b604d2be0238d58e5124648bbaf541848a7aa330750c0238618bd082bc3ea"
    end

    on_intel do
      url "https://github.com/maxgfr/sift/releases/download/v0.7.0/sift-macos-x64"
      sha256 "bd6012cbbb036a360d78be8b0d49706a429bff30bae65ca4c6b984e174c8ea6e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/sift/releases/download/v0.7.0/sift-linux-arm64"
      sha256 "6b92c848cf33004a15acbe0bcf83bb749d06f4db84c44805b6d1b821b884663a"
    end

    on_intel do
      url "https://github.com/maxgfr/sift/releases/download/v0.7.0/sift-linux-x64"
      sha256 "48891895a1d60926039622ae53c677bd6c6a70140cfd8f37d48d7a8ede50b414"
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
