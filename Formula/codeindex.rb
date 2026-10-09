class Codeindex < Formula
  desc "Zero-dependency repo-indexing engine: link-graph, symbols, callers, MCP server"
  homepage "https://github.com/maxgfr/codeindex"
  url "https://github.com/maxgfr/codeindex/archive/refs/tags/v2.31.5.tar.gz"
  sha256 "48fbed55b422fc9a952a9078db98a38153cb546790d9058c7e56651fa28e671f"
  version "2.31.5"
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
