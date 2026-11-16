class LlmModels < Formula
  desc "Find, compare and price LLM models from OpenRouter and models.dev"
  homepage "https://github.com/maxgfr/llm-models"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.16.2/llm-models-macos-arm64"
      sha256 "cda96dcc163abaa6b35b75757e6d8c30a111bb43411d0766cc4ee5c7643d27e2"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.16.2/llm-models-macos-x64"
      sha256 "7a1395801df0213d51cd5c73fb31eb461c4a00ccae4e873e042d65589b137317"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.16.2/llm-models-linux-arm64"
      sha256 "8d026f24a86733141ae1021a83303350fc0a83989b0703c7ededbea25acc2f4d"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.16.2/llm-models-linux-x64"
      sha256 "604da06cd8ba8ea543151fb4c7772db8a5113e9a4d7e581a5693bf59bcd3fcbc"
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
