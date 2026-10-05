class Swarmdeck < Formula
  desc "Drive a Swarmdeck torrent server, and make and edit .torrent files (CLI + MCP)"
  homepage "https://github.com/maxgfr/swarmdeck"
  url "https://github.com/maxgfr/swarmdeck/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "7da93e593ebd3ebba882505373b9df819916409f70793cd09d5afc5e23611e18"

  depends_on "node"

  def install
    # The command line, the MCP server, and the page's lib/ they share; only the MCP server has
    # dependencies (@modelcontextprotocol/sdk and zod), the dev ones are the site's tests.
    libexec.install "cli", "lib", "mcp", "package.json", "package-lock.json"
    system "npm", "ci", "--prefix", libexec, "--omit=dev", "--ignore-scripts"
    env = { PATH: "#{formula_opt_bin("node")}:$PATH" }
    (bin/"swarmdeck").write_env_script libexec/"cli/swarmdeck.mjs", env
    (bin/"swarmdeck-mcp").write_env_script libexec/"mcp/server.mjs", env
  end

  def caveats
    <<~EOS
      swarmdeck drives a Swarmdeck server: run one with `npm run local` in a checkout of
      https://github.com/maxgfr/swarmdeck, or the Docker image. It is found at
        SWARMDECK_URL    (default http://127.0.0.1:8080)
        SWARMDECK_TOKEN  its AUTH_TOKEN, when it has one

      The MCP server, for Claude Code:
        claude mcp add swarmdeck --env SWARMDECK_URL=http://127.0.0.1:8080 -- swarmdeck-mcp
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/swarmdeck --version").strip

    # .torrent files need no server: make one, read it back, get its magnet.
    (testpath/"Album/one.txt").write "one"
    (testpath/"Album/two.txt").write "two"
    system bin/"swarmdeck", "create", testpath/"Album", "-o", testpath/"album.torrent"
    assert_match "Album", shell_output("#{bin}/swarmdeck inspect #{testpath}/album.torrent")
    assert_match "magnet:?xt=urn:btih:", shell_output("#{bin}/swarmdeck magnet #{testpath}/album.torrent")

    # No server here: an error that says how to start one.
    output = shell_output("#{bin}/swarmdeck list --server http://127.0.0.1:9 2>&1", 1)
    assert_match "npm run local", output

    # The MCP server answers its handshake.
    init = '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18",' \
           '"capabilities":{},"clientInfo":{"name":"brew","version":"1"}}}'
    assert_match '"name":"swarmdeck"', pipe_output(bin/"swarmdeck-mcp", "#{init}\n", 0)
  end
end
