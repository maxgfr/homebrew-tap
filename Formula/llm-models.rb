class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  version "v1.8.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.8.1/llm-models-macos-arm64"
      sha256 "221be11af8ab2e95bc699c07e49c16cb42357373fc73e9841f8204eee90f1219"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.8.1/llm-models-macos-x64"
      sha256 "b4bf8a861368e9103d3e41ad64b660089480a8c3e98ae66db9d10de68c2a8a61"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.8.1/llm-models-linux-arm64"
      sha256 "41035dd73f352a44ad7f3bd4940809ae7a1c6edca67b010bee81908f0000a51c"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.8.1/llm-models-linux-x64"
      sha256 "31e6640d0a9d2ae6df51cf0c39a6941b75612fd502eb4410c39a475fb2c5e6ba"
    end
  end

  def install
    binary = Dir["llm-models-*"].first

    if binary.nil?
      opoo "No llm-models binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "llm-models"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llm-models --version")
  end
end
