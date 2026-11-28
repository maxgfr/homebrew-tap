class Codeindex < Formula
  desc "Index the symbols, imports, callers and link graph of a repo, with MCP server"
  homepage "https://github.com/maxgfr/codeindex"
  url "https://github.com/maxgfr/codeindex/archive/refs/tags/v2.32.1.tar.gz"
  sha256 "e6153c49e461a48e7f912ab34a4c245a69cf20492d343081a842c4e8e29b537e"
  license "MIT"

  depends_on "node"

  def install
    # The engine ships prebuilt: a pure library bundle (engine.mjs), a static
    # CLI/MCP wrapper (cli.mjs) and the optional tree-sitter grammar sidecar.
    libexec.install "scripts/engine.mjs", "scripts/cli.mjs", "scripts/grammars"
    (bin/"codeindex").write <<~SH
      #!/bin/bash
      exec node "#{libexec}/cli.mjs" "$@"
    SH
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/codeindex version")
    (testpath/"src.ts").write("export function hello(): number { return 1; }\n")
    output = shell_output("#{bin}/codeindex symbols --repo #{testpath}")
    assert_match "hello", output
  end
end
