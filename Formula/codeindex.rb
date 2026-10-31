class Codeindex < Formula
  desc "Zero-dependency repo-indexing engine: link-graph, symbols, callers, MCP server"
  homepage "https://github.com/maxgfr/codeindex"
  url "https://github.com/maxgfr/codeindex/archive/refs/tags/v2.31.14.tar.gz"
  sha256 "07e58768f93b37516b20a4f4f047e17506425317c7f14e01119f8031ba13df87"
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
