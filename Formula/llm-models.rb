class LlmModels < Formula
  desc "Find, compare and price LLM models from OpenRouter and models.dev"
  homepage "https://github.com/maxgfr/llm-models"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.16.1/llm-models-macos-arm64"
      sha256 "156861b0969fed6d0d9b0193b9548799f4e103b366de70a26d40bcc1accac36a"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.16.1/llm-models-macos-x64"
      sha256 "8e18d71bff9d5014d40420b47be81582af9532182fd43b348acc14cc6f389e91"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.16.1/llm-models-linux-arm64"
      sha256 "66a7ad9368dce989b916526ed04e68d4f9d2bba5447e0fd1767656270f3e81ef"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.16.1/llm-models-linux-x64"
      sha256 "7afdb30041b923889d329f3d843a173723e159806dba07f612d283b8a018161c"
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
