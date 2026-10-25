class Codeindex < Formula
  desc "Zero-dependency repo-indexing engine: link-graph, symbols, callers, MCP server"
  homepage "https://github.com/maxgfr/codeindex"
  url "https://github.com/maxgfr/codeindex/archive/refs/tags/v2.31.12.tar.gz"
  sha256 "87535dc3efe9a39ad7fe0888eb57d828116c3bb919c35f8092e3f5d754c2d2eb"
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
