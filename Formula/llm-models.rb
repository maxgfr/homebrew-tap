class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.12.0/llm-models-macos-arm64"
      sha256 "cdc63d7ad98a8a1be1c0a2afcac68fafa0a848a344ebf5151167e417837c9b28"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.12.0/llm-models-macos-x64"
      sha256 "b67a4be894744e2601607e530c3e672d013d6f30b3245b8a9f1e8c6add93d1bc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.12.0/llm-models-linux-arm64"
      sha256 "cc5accff9843bb1baf5cd792b59e1a5fa4f114c1079860bff7bc06478a414dcc"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.12.0/llm-models-linux-x64"
      sha256 "32e74858a5bbcd93633d919bdece2b4c6089ac4654fbd577c93e0fa0450c68ac"
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
