class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  version "v1.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.3.0/llm-models-macos-arm64"
      sha256 "b603893b8952d1f447d295e4c2637fdc0448801f290b63740cd7daa2430662a7"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.3.0/llm-models-macos-x64"
      sha256 "011f6bb6f07d4eb9efa47e6f2430153b344fbd1fd533be72331c92c08b4687ee"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.3.0/llm-models-linux-arm64"
      sha256 "51fb2ef831d8b6607fc52cfe15ce9be106206257fe7dd15853524c14f753a6a5"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.3.0/llm-models-linux-x64"
      sha256 "2ff6a91cee27894498861da5ffa93a98ad5c8bedf3bfe35676cd671aa53f13b7"
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
