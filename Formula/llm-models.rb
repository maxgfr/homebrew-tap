class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  version "v1.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.3.1/llm-models-macos-arm64"
      sha256 "f86b4424acb20cb12b9797636a8f92ab6873d87e61fdd13358a748215bad728d"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.3.1/llm-models-macos-x64"
      sha256 "e5e5e04bc7a294dfe4f19918e64a1026e359d38aa4d76e04ce5da124696d3eff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.3.1/llm-models-linux-arm64"
      sha256 "c68126173694755480afa83195eb4397ae733b2066dc37095a9f2467d5a774fc"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.3.1/llm-models-linux-x64"
      sha256 "8368d831b723eb341025a6576ecbae295940a3a00f79e5a2b669e7f2e241285b"
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
