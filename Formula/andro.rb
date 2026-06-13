class Andro < Formula
  desc "Run Android apps from the macOS CLI on a disposable native emulator"
  homepage "https://github.com/maxgfr/andro"
  version "v1.1.1"
  license "MIT"

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/andro/releases/download/v1.1.1/andro-macos-arm64"
      sha256 "a5305327b7320e3f513370bd3ae1fb67d4a1da1f6f5d192a68044ac6af9d9863"
    end

    on_intel do
      url "https://github.com/maxgfr/andro/releases/download/v1.1.1/andro-macos-x64"
      sha256 "5bd3ff38ce34a777fa5682d3cbdbe80328fe5601ccdba36d043ba3ca26754b94"
    end
  end

  def install
    binary = Dir["andro-*"].first

    if binary.nil?
      opoo "No andro binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "andro"
  end

  test do
    assert_match "andro", shell_output("#{bin}/andro --help 2>&1")
  end
end
