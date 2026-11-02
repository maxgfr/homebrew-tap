class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.14.1/llm-models-macos-arm64"
      sha256 "88506362582fdef5e14512a5ff4bc6ad4339a61b35a0386cb92e20d7afb5dbce"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.14.1/llm-models-macos-x64"
      sha256 "af656f9939016b772c7b62f59b59d21ac6c87f926825e5e7bc12ad9bbe5eb935"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.14.1/llm-models-linux-arm64"
      sha256 "7dd560675350f1f1c30ea7b1421794a645b982426f8f7c4ec7f8964236378173"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.14.1/llm-models-linux-x64"
      sha256 "7157c31076dad414e494814837a24185d6c84d5780c474bf13eb51eb64dca8b6"
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
