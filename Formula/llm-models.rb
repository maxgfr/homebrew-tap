class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  version "v1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.0.0/llm-models-macos-arm64"
      sha256 "PLACEHOLDER"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.0.0/llm-models-macos-x64"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.0.0/llm-models-linux-arm64"
      sha256 "PLACEHOLDER"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.0.0/llm-models-linux-x64"
      sha256 "PLACEHOLDER"
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
