class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  version "v1.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.4.0/llm-models-macos-arm64"
      sha256 "8fe54ec722a4a13ef7a30a7494720ba92b2cf828874ba2236f1ee276cf5da2f7"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.4.0/llm-models-macos-x64"
      sha256 "4e35f59a35318896bafa8375aaae667ba85129ce764e22a86b87ddac5d26be3d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.4.0/llm-models-linux-arm64"
      sha256 "5c611748555184557e59c60a5fe49795a5603a9d35305de1c92296a9e2aa6a2b"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.4.0/llm-models-linux-x64"
      sha256 "64756f50d426b98c87e1109346fa68892d3f6233065ff169d4f6d61249776154"
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
