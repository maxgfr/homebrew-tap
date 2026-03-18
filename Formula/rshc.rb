class Rshc < Formula
  desc "Rust reimplementation of SHC — encrypts shell scripts into compiled binaries"
  homepage "https://github.com/maxgfr/rshc"
  version "v1.5.1"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/rshc/releases/download/v1.5.1/rshc-macos-arm64"
      sha256 "f237c36f8895b3c42bd297d67422beed503f29a151bcb483dd61407742bb99a7"
    end

    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.5.1/rshc-macos-x64"
      sha256 "6aae837c8bf6d793faecd46ede3d779bd38d7e46e8adc1155e3bef7e87445063"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.5.1/rshc-linux-x64"
      sha256 "0d8f36bb7b86d92fb73c7516a3f2e64d6a2ef8a06c170af9a04a44df07578ce8"
    end
  end

  resource "rshc-runner" do
    on_macos do
      on_arm do
        url "https://github.com/maxgfr/rshc/releases/download/v1.5.1/rshc-runner-macos-arm64"
        sha256 "71f42ecf2053c04b4076848c1d316a2f969a883415940ceb1ad9992050b8473e"
      end

      on_intel do
        url "https://github.com/maxgfr/rshc/releases/download/v1.5.1/rshc-runner-macos-x64"
        sha256 "bebd6e2b408d179afaf597640bd6677c26f029e545bd0ff858b34e5c3b820eab"
      end
    end

    on_linux do
      on_intel do
        url "https://github.com/maxgfr/rshc/releases/download/v1.5.1/rshc-runner-linux-x64"
        sha256 "77f8789eb8a9f50f8c75c11841965e430ba2a31d590d381d015ac452d677b1c0"
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
