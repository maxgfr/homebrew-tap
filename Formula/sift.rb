class Sift < Formula
  desc "Will this model fit and run fast on your machine? Answered before you download it"
  homepage "https://github.com/maxgfr/sift"
  version "v0.6.0"
  license "MIT"

  # homebrew/core ships an unrelated `sift`, a grep alternative. Both put a
  # `sift` on PATH, so Homebrew must be told rather than left to fail at link
  # time with nothing the user can act on.
  conflicts_with "sift", because: "both install a `sift` binary"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/sift/releases/download/v0.6.0/sift-macos-arm64"
      sha256 "8a15e7398ee848ffbad12e31cea70e6e14294d157179e39dfe943091e1bc8733"
    end

    on_intel do
      url "https://github.com/maxgfr/sift/releases/download/v0.6.0/sift-macos-x64"
      sha256 "b35ce76b1a7436d963b2c58056cee7a8ce94946bf1148fda49dd2c1f728e26d9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/sift/releases/download/v0.6.0/sift-linux-arm64"
      sha256 "7d1fa608a7301436be7609160c8d90d7a31958bad65318624cffd2bc5be097b3"
    end

    on_intel do
      url "https://github.com/maxgfr/sift/releases/download/v0.6.0/sift-linux-x64"
      sha256 "e2fe684ee566780725897834d6928e9c1e99d4beefc247d8216b78b307ddcc56"
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
