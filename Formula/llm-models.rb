class LlmModels < Formula
  desc "Fetch latest LLM models from OpenRouter and models.dev APIs"
  homepage "https://github.com/maxgfr/llm-models"
  version "v1.2.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.2.6/llm-models-macos-arm64"
      sha256 "34263e2539f09e3545e635766c0f3a344fd9a9510d22b67781fbe9e496a3c8b9"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.2.6/llm-models-macos-x64"
      sha256 "3896704d8f8d21a66f0b769dd378ed6d03fb15f19ce5fd5cfc42a7155f42b5cc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.2.6/llm-models-linux-arm64"
      sha256 "400c2671cc201d656a9d34e8d0355baae407e5683ef451b3511a4d535d9dce51"
    end

    on_intel do
      url "https://github.com/maxgfr/llm-models/releases/download/v1.2.6/llm-models-linux-x64"
      sha256 "67d7bf1870b6fc8b3055016c9a779c70f643f698ed24886931caa9314b598712"
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
