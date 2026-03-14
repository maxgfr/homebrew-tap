    class Rshc < Formula
      desc "Rust reimplementation of SHC — encrypts shell scripts into compiled binaries"
      homepage "https://github.com/maxgfr/rshc"
      version "v1.3.2"
      license "GPL-3.0"

      on_macos do
        on_arm do
          url "https://github.com/maxgfr/rshc/releases/download/v1.3.2/rshc-macos-arm64"
          sha256 "65c098e70276e776b0f15feec2d7e2c64f8ad637c9e31faf00a1b1ee5bff5cbe"
        end

        on_intel do
          url "https://github.com/maxgfr/rshc/releases/download/v1.3.2/rshc-macos-x64"
          sha256 "c468961aa97b4f82a14de4fe623f39d9136857de0032f3582f0f480ca466ccf1"
        end
      end

      on_linux do
        on_intel do
          url "https://github.com/maxgfr/rshc/releases/download/v1.3.2/rshc-linux-x64"
          sha256 "340b02b6e7235d423438f950cf8621534fef0022036c6abd4802f196fd77c0ee"
        end
      end

      resource "rshc-runner" do
        on_macos do
          on_arm do
            url "https://github.com/maxgfr/rshc/releases/download/v1.3.2/rshc-runner-macos-arm64"
            sha256 "710ed3eaf7e98d7a98871963ac57932dcb9be54f6c677f74a4d5079c797bd066"
          end

          on_intel do
            url "https://github.com/maxgfr/rshc/releases/download/v1.3.2/rshc-runner-macos-x64"
            sha256 "bfd43a45dad0ceb395355d273435f5edc9403dc4a3fa86a86f7665986b06551f"
          end
        end

        on_linux do
          on_intel do
            url "https://github.com/maxgfr/rshc/releases/download/v1.3.2/rshc-runner-linux-x64"
            sha256 "d5501f0fac85ca75c2f9b7b6b3e33594fc50f323597427557ae71d4d83b93565"
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
