class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  version "v1.2.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.2.2/llm-models-macos-arm64"
      sha256 "408561730736d4fe3fe027711472070edee10c2f0efdf29870532361fd8a2ecb"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.2.2/llm-models-macos-x64"
      sha256 "c73bb60f4d7b9642d5ab34eca8640188b347a818b9cb5ad01e4a32b2d85c0bc4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.2.2/llm-models-linux-arm64"
      sha256 "9ebe1b01efcce6f6f44cbbd58eb0142d42fcc84d46236d835bd64530a87cb792"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.2.2/llm-models-linux-x64"
      sha256 "59aa22a4dee606e14db5a5214c12e4c76a07947ed375195449f42b7ee2f50a4f"
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
