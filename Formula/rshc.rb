class Rshc < Formula
  desc "Rust reimplementation of SHC — encrypts shell scripts into compiled binaries"
  homepage "https://github.com/maxgfr/rshc"
  version "v1.3.3"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/rshc/releases/download/v1.3.3/rshc-macos-arm64"
      sha256 "fe4b0c961ee7f9818c46946d25881c92e4cb08641fdcd94ab4416cf6c37334ad"
    end

    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.3.3/rshc-macos-x64"
      sha256 "57412f0c982790197cd414c35f5dcf9c03b8c793bb0de41462c4766d687012c1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.3.3/rshc-linux-x64"
      sha256 "ef685d7c75257667643faa625957be75722dddd0310d6c906559e16a07280366"
    end
  end

  resource "rshc-runner" do
    on_macos do
      on_arm do
        url "https://github.com/maxgfr/rshc/releases/download/v1.3.3/rshc-runner-macos-arm64"
        sha256 "7c23086ecbefe871d93e5ce8b95ebfb08a7c4b13a735f95b66434d4460c72b40"
      end

      on_intel do
        url "https://github.com/maxgfr/rshc/releases/download/v1.3.3/rshc-runner-macos-x64"
        sha256 "5229fb77398a8019254bf490b4e79f3a157614bd83066ba43ca9bc2babe6655d"
      end
    end

    on_linux do
      on_intel do
        url "https://github.com/maxgfr/rshc/releases/download/v1.3.3/rshc-runner-linux-x64"
        sha256 "2df9062fd753b3e2e4747f19a4193a47d05f3cdb8530d1637d2482ef2e726daa"
      end
    end
  end

  def install
    binary = Dir["rshc-*"].reject { |f| f.include?("runner") }.first

    if binary.nil?
      opoo "No rshc binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "rshc"

    resource("rshc-runner").stage do
      runner = Dir["rshc-runner-*"].first
      if runner
        chmod 0755, runner
        bin.install runner => "rshc-runner"
      end
    end
  end

  test do
    assert_match "rshc", shell_output("#{bin}/rshc --help 2>&1")
  end
end
