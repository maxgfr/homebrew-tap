class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  version "v1.2.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.2.3/llm-models-macos-arm64"
      sha256 "9cdad6837c484f1054a019eea5f229c841677d6292d55f2eed9130babb67cb56"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.2.3/llm-models-macos-x64"
      sha256 "4e5437dd3b18b9abb68904c7b2942083d41a79ca63586dc865d73982db7865bc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.2.3/llm-models-linux-arm64"
      sha256 "6d9d4400426d6bf8d1a966706c557f9fed25534fad8bdbd8dc0bab78d7a87e75"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.2.3/llm-models-linux-x64"
      sha256 "c715cfa4e2cb14f49dc2ab84fc24e0b13e3e59ad25371f032e4f3b2adeb00fe7"
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
