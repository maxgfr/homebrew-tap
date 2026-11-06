class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.16.0/llm-models-macos-arm64"
      sha256 "d62cf80cd8f24c3f946e2fecdc3293922d362193768283bc32f02ad408427b35"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.16.0/llm-models-macos-x64"
      sha256 "ccc6ab9793e9f61581b444c2ce8f290c2c74a6562bba75f9f056180e0fa9816f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.16.0/llm-models-linux-arm64"
      sha256 "435d4d22895c7ad7f2f4d6df756ce05324b79eef529b45776585ed35973f580f"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.16.0/llm-models-linux-x64"
      sha256 "73a91e7f24181b3eceb19256bd5f57c9cbbd31f93eb6e11b99a9d35a205168c2"
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
