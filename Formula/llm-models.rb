class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  version "v1.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.6.0/llm-models-macos-arm64"
      sha256 "fc259e808dce4bbfcc5148d2c8f3e89371499eb9fbadf38909432b7df11b84d2"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.6.0/llm-models-macos-x64"
      sha256 "83438d6ce7de45eb37fe9c265c47e3e17bb7f9ca556eace7e349a780812f6eb1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.6.0/llm-models-linux-arm64"
      sha256 "f57a14931bbd1a3a5145f855fa7133b2ab52ed611a8d04545ba6bf694c6ff207"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.6.0/llm-models-linux-x64"
      sha256 "d7f8e1518b26c23916f006d13a6c4bd5ac399bcad47cd3e07e27a6d1465e7e75"
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
