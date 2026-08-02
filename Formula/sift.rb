class Sift < Formula
  desc "Will this model fit and run fast on your machine? Answered before you download it"
  homepage "https://github.com/maxgfr/sift"
  version "v0.4.0"
  license "MIT"

  # homebrew/core ships an unrelated `sift`, a grep alternative. Both put a
  # `sift` on PATH, so Homebrew must be told rather than left to fail at link
  # time with nothing the user can act on.
  conflicts_with "sift", because: "both install a `sift` binary"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/sift/releases/download/v0.4.0/sift-macos-arm64"
      sha256 "d33ffa91b9c4c8fc7c8908fe9df8317851fe8bf8505e1d527b51a518669f250e"
    end

    on_intel do
      url "https://github.com/maxgfr/sift/releases/download/v0.4.0/sift-macos-x64"
      sha256 "22a2d28c809dd87071d9705ddda99da705d898f4ef721ba21bc47c7f0b1d37bf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/sift/releases/download/v0.4.0/sift-linux-arm64"
      sha256 "130143975903df3321f5c122fe14ea57cdae7a585159edaacf97343ff2b286fb"
    end

    on_intel do
      url "https://github.com/maxgfr/sift/releases/download/v0.4.0/sift-linux-x64"
      sha256 "7e1968ab857685e177b8dfa5f76aa3cb133007c67c403d6136e697cdf0322923"
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
