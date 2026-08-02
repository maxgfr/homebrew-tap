class Sift < Formula
  desc "Will this model fit and run fast on your machine? Answered before you download it"
  homepage "https://github.com/maxgfr/sift"
  version "v0.3.0"
  license "MIT"

  # homebrew/core ships an unrelated `sift`, a grep alternative. Both put a
  # `sift` on PATH, so Homebrew must be told rather than left to fail at link
  # time with nothing the user can act on.
  conflicts_with "sift", because: "both install a `sift` binary"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/sift/releases/download/v0.3.0/sift-macos-arm64"
      sha256 "b915c8e6f6931073025dde9d151bde1ff459dc496559ed6b58583a857c37d4ec"
    end

    on_intel do
      url "https://github.com/maxgfr/sift/releases/download/v0.3.0/sift-macos-x64"
      sha256 "6fb84d50d3ce7c100e6326a20c22e32da154051a3046763c5247a703ce0dddaf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/sift/releases/download/v0.3.0/sift-linux-arm64"
      sha256 "debabaa04398f2e902ca63bbfae0f413b5b7025abb080ee934a18bd57716b5b5"
    end

    on_intel do
      url "https://github.com/maxgfr/sift/releases/download/v0.3.0/sift-linux-x64"
      sha256 "5cf3ba2a580090281b9a62ad99e5cfac6a9b74b0df09a7f238c13c210879275d"
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
