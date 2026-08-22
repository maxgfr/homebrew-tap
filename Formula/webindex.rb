class Webindex < Formula
  desc "Web-retrieval engine: URL to clean text (HTML, PDF, office), MCP server"
  homepage "https://github.com/maxgfr/webindex"
  url "https://github.com/maxgfr/webindex/archive/refs/tags/v1.18.3.tar.gz"
  version "1.18.3"
  sha256 "f7ba1e40da153ee83cc49cc593ec93852b67f4fe51bdb455a001bddab7811f53"
  license "MIT"

  depends_on "node"

  def install
    # The CLI ships prebuilt and is fully self-contained — a single tsup bundle
    # importing nothing but Node builtins. engine.mjs, the library the agent
    # skills vendor, is NOT needed at runtime and is deliberately not installed.
    libexec.install "scripts/webindex.mjs"
    (bin/"webindex").write <<~SH
      #!/bin/bash
      exec node "#{libexec}/webindex.mjs" "$@"
    SH
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/webindex version")

    # Extraction, offline: an HTML file becomes readable text with no markup.
    html = "<html><body><article><h1>Rate limiting</h1>" \
           "<p>Token buckets smooth bursts.</p></article></body></html>"
    (testpath/"page.html").write(html)
    output = shell_output("#{bin}/webindex extract #{testpath}/page.html")
    assert_match "Rate limiting", output
    refute_match "<article>", output

    # doctor reports the optional helpers without requiring any of them.
    assert_match "pdf rungs", shell_output("#{bin}/webindex doctor")
  end
end
