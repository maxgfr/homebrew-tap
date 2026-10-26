class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.14.0/llm-models-macos-arm64"
      sha256 "3bce85fb7f6367d19d27b5b7f72e6abff443bb48db62970cdc4485f4ce10cd77"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.14.0/llm-models-macos-x64"
      sha256 "b1c060e16580904502e1e1ed210174c46e75ce1dcf3ed2148020dee9a478c6e2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.14.0/llm-models-linux-arm64"
      sha256 "a76d979353c3f5bfa2bde29370d7e36aead8035cec67c874f3d6737ee4b1f11b"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.14.0/llm-models-linux-x64"
      sha256 "39ec87b4441477e60c5a5865385b041aa790c21a796e78e5e42b95e9d5ed61fe"
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
