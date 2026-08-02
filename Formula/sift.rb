class Sift < Formula
  desc "Will this model fit and run fast on your machine? Answered before you download it"
  homepage "https://github.com/maxgfr/sift"
  version "v0.4.1"
  license "MIT"

  # homebrew/core ships an unrelated `sift`, a grep alternative. Both put a
  # `sift` on PATH, so Homebrew must be told rather than left to fail at link
  # time with nothing the user can act on.
  conflicts_with "sift", because: "both install a `sift` binary"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/sift/releases/download/v0.4.1/sift-macos-arm64"
      sha256 "ec9232dccb5da2af156fa7dc4263b652a6d0d8eb53431a8904dc68730d2c8c41"
    end

    on_intel do
      url "https://github.com/maxgfr/sift/releases/download/v0.4.1/sift-macos-x64"
      sha256 "58e7d733ee5e7770094934cc9f26da81298fe55b8644d3d84ed96e26b099480e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/sift/releases/download/v0.4.1/sift-linux-arm64"
      sha256 "60e2fad70b54ebb8ef0f32710326cc692bc9dc65ef5703ddb9225cfffb1057b9"
    end

    on_intel do
      url "https://github.com/maxgfr/sift/releases/download/v0.4.1/sift-linux-x64"
      sha256 "6d888e4c49000dccd206db3a739140f02ebf04940ab3749f7de2cf0bfeb201c3"
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
