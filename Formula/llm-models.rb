class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  version "v1.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.7.0/llm-models-macos-arm64"
      sha256 "790dd847bdadc841ed5e7c7a98c3022fd1f583a08b676d385e3404993eaddc6f"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.7.0/llm-models-macos-x64"
      sha256 "b8c6fc7bccb5949c69ec13865fccde5d061efa697b6775a5b5cdf76e8e95da80"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.7.0/llm-models-linux-arm64"
      sha256 "85b3c4aaf75c95b4660828b3fa1a785da7eff83488912fb09f5020caefe4a6a4"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.7.0/llm-models-linux-x64"
      sha256 "9ff5f6ae88148c8fcd3e3cf666fba8717090eb72e5e414abc4d8fcc38e3b6f65"
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
