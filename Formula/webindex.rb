class Webindex < Formula
  desc "Web-retrieval engine: URL to clean text (HTML, PDF, office), MCP server"
  homepage "https://github.com/maxgfr/webindex"
  url "https://github.com/maxgfr/webindex/archive/refs/tags/v1.33.0.tar.gz"
  version "1.33.0"
  sha256 "bf82986ad81e92cfeb9f08cd62612cc689e708471b4a450cf9e2e2ec3e1332f4"
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
