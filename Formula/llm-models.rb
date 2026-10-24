class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.13.0/llm-models-macos-arm64"
      sha256 "5afb4eae10298fd6554f8724a1b6f776fe9d48d8eb932963d3d814b819357f6d"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.13.0/llm-models-macos-x64"
      sha256 "8e443391e6885bdc319ddfc46f4f6bcb6a0ec2af78451f056840256ab6d92b4a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.13.0/llm-models-linux-arm64"
      sha256 "e0822d66f306eb3d45ecdc60214e310b9c2be2af578efdb0d749d97ed446830a"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.13.0/llm-models-linux-x64"
      sha256 "784ff50d1be78f95cd8a8115d3bd3576f2e04d554040f900c0c2cb827a2811a9"
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
