class Sift < Formula
  desc "Will this model fit and run fast on your machine? Answered before you download it"
  homepage "https://github.com/maxgfr/sift"
  version "v0.2.0"
  license "MIT"

  # homebrew/core ships an unrelated `sift`, a grep alternative. Both put a `sift` on
  # PATH, so Homebrew must be told rather than left to fail at link time with nothing
  # the user can act on.
  conflicts_with "sift", because: "both install a `sift` binary"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/sift/releases/download/v0.2.0/sift-macos-arm64"
      sha256 "3bce1e04326e860637396a8ddfbeb17d8db81b98ef2a3259f87c379a99ea202c"
    end

    on_intel do
      url "https://github.com/maxgfr/sift/releases/download/v0.2.0/sift-macos-x64"
      sha256 "f119dd6f5a48d50125af9cafdc96fef231389e7a2e488faec071b0b3cf0b130d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/sift/releases/download/v0.2.0/sift-linux-arm64"
      sha256 "071be37f3558fa898929fca26037eca858bbf22bfe9f110f686580382bec704e"
    end

    on_intel do
      url "https://github.com/maxgfr/sift/releases/download/v0.2.0/sift-linux-x64"
      sha256 "84af5bc0aa8c8921bb72123e75e4cc63337de7128fb9380f51240f25ae9e5e6d"
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
    # `engines` needs no network and no model, so it is a real end-to-end check rather
    # than a version string echo.
    assert_match "known engines", shell_output("#{bin}/sift engines 2>&1")
  end
end
