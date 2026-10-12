class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  version "v1.5.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.5.1/llm-models-macos-arm64"
      sha256 "746dc1acfe2f4245744a3074ccf23b0722dab2be665d8701af4d627627c1e965"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.5.1/llm-models-macos-x64"
      sha256 "2ee4adca5e7865a458ba2933c2605ab1882d52a0f76699caf0ab5201bba538aa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.5.1/llm-models-linux-arm64"
      sha256 "79c0bd2f90fd48634156ca75364dd0084b6fa24f531dd12cade085ca45071c2f"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.5.1/llm-models-linux-x64"
      sha256 "9c66df618451bb5c9ba75420903620aa81b18152b675ef39037aaf0af08d9e3d"
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
