class Rshc < Formula
  desc "Rust reimplementation of SHC — encrypts shell scripts into compiled binaries"
  homepage "https://github.com/maxgfr/rshc"
  version "v1.6.2"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/rshc/releases/download/v1.6.2/rshc-macos-arm64"
      sha256 "484f81b4d3cf2ec714f73ae366ee305f4ef6f2a371f6f99dc360b1114d504c74"
    end

    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.6.2/rshc-macos-x64"
      sha256 "e2814a5b333e5120f971bb7c09f6ecd87b174bc82ac3c331ffd0aa7495a55954"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.6.2/rshc-linux-x64"
      sha256 "9f5c0c5784d8c358287fc220be71432df0dad017128587acb2d90c43f8eca514"
    end
  end

  resource "rshc-runner" do
    on_macos do
      on_arm do
        url "https://github.com/maxgfr/rshc/releases/download/v1.6.2/rshc-runner-macos-arm64"
        sha256 "db0d0b072227757f221036674a512693a560fd4aca33b7c620e6c23f3ef8cca4"
      end

      on_intel do
        url "https://github.com/maxgfr/rshc/releases/download/v1.6.2/rshc-runner-macos-x64"
        sha256 "f98373b2497cc35db8d83558931a24760859bb998842c18519ff6701c3dd0337"
      end
    end

    on_linux do
      on_intel do
        url "https://github.com/maxgfr/rshc/releases/download/v1.6.2/rshc-runner-linux-x64"
        sha256 "ddf287028b727427b962cfd9df177616f84887d97f854ed74964d357e45a90fc"
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
