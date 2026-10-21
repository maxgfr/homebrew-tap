class Rshc < Formula
  desc "Rust reimplementation of SHC — encrypts shell scripts into compiled binaries"
  homepage "https://github.com/maxgfr/rshc"
  license "GPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/rshc/releases/download/v1.6.2/rshc-macos-arm64"
      sha256 "40d6b0951667d62f233f7583fd6889e7ca61a2da1ec49c39c49d6ff323580d01"
    end

    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.6.2/rshc-macos-x64"
      sha256 "7402a5d334b4ed84000c83f03344acf5fbd1d1e5914af3214ca7a5f7386f8309"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/maxgfr/rshc/releases/download/v1.6.2/rshc-linux-x64"
      sha256 "fc37d9c8f27dac89203e7557f51a34c5269c43c821dfbcd2a28622d989239912"
    end
  end

  resource "rshc-runner" do
    on_macos do
      on_arm do
        url "https://github.com/maxgfr/rshc/releases/download/v1.6.2/rshc-runner-macos-arm64"
        sha256 "bebc883282a4bc39ac0f61ef86e3a4ffed1c11a2faab3115ae49c2b20a1038d7"
      end

      on_intel do
        url "https://github.com/maxgfr/rshc/releases/download/v1.6.2/rshc-runner-macos-x64"
        sha256 "92a1c2909dcbbf72c0ec5a5b984eef15426e37d06c6535b7e419cab124b4b447"
      end
    end

    on_linux do
      on_intel do
        url "https://github.com/maxgfr/rshc/releases/download/v1.6.2/rshc-runner-linux-x64"
        sha256 "fbeaca38918183902a3fbe723f6373c3abc1331421508bf86dd7bf8f950072ee"
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
