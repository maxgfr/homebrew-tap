class Sift < Formula
  desc "Will this model fit and run fast on your machine? Answered before you download it"
  homepage "https://github.com/maxgfr/sift"
  license "MIT"

  # homebrew/core ships an unrelated `sift`, a grep alternative. Both put a
  # `sift` on PATH, so Homebrew must be told rather than left to fail at link
  # time with nothing the user can act on.
  conflicts_with "sift", because: "both install a `sift` binary"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/sift/releases/download/v0.7.1/sift-macos-arm64"
      sha256 "570e1f801893f37ed49019b4db0dd76603bf515bcb73c296d7595982564a9f23"
    end

    on_intel do
      url "https://github.com/maxgfr/sift/releases/download/v0.7.1/sift-macos-x64"
      sha256 "fea760f4d0a6daaa9ba9e0122a57c7f7d63743c8a6dc9057267ac0e6dd91cb6e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/sift/releases/download/v0.7.1/sift-linux-arm64"
      sha256 "aedb261756eaacaeb83465b6f4f874f7010a682cadc419f1cb9b18fab152a609"
    end

    on_intel do
      url "https://github.com/maxgfr/sift/releases/download/v0.7.1/sift-linux-x64"
      sha256 "34b80bd89e4592c49a0b22406f8ed2d8000d40045865384f7a4c66d4316086d4"
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
