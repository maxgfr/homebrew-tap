class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  version "v1.2.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.2.7/llm-models-macos-arm64"
      sha256 "e7d4b2fce5f4a4d27c11b762affe0e55f16728ab2f6cccb0a351525842fff853"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.2.7/llm-models-macos-x64"
      sha256 "7a3e24fb302752cad8d4c9322251c112946035ee4397f826dc14dea2d84c0fcc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.2.7/llm-models-linux-arm64"
      sha256 "e27184ea988ee3b203a00f72e57c51ec295fe1d86ef9c027032c558d320e8ca4"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.2.7/llm-models-linux-x64"
      sha256 "af80567c1674473faa004ef5a6d65ba21db5c5256f5666df556b6a9ea5a8fd73"
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
