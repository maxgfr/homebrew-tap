class Troupe < Formula
  desc "Drive a self-hosted Troupe studio (AI actor videos) from the terminal"
  homepage "https://github.com/maxgfr/troupe"
  url "https://github.com/maxgfr/troupe/releases/download/v0.3.0/troupe-cli-0.3.0.mjs"
  sha256 "4f64210561e13a5a6e805aa5351f71d1aec687977c921548455f05834e0f681f"
  license "MIT"

  depends_on "node"

  def install
    libexec.install "troupe-cli-#{version}.mjs" => "troupe.mjs"
    (bin/"troupe").write <<~EOS
      #!/bin/bash
      exec "#{formula_opt_bin("node")}/node" "#{libexec}/troupe.mjs" "$@"
    EOS
  end

  def caveats
    <<~EOS
      The studio itself is not installed here: run it with Docker
      (https://github.com/maxgfr/troupe#quick-start), then
        troupe login --url http://localhost:3100
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/troupe --version").strip
    # No studio needed: the address of its Projects page.
    ENV["TROUPE_CONFIG_DIR"] = testpath/"config"
    assert_equal "http://127.0.0.1:9/dashboard",
                 shell_output("#{bin}/troupe open --print --url http://127.0.0.1:9").strip
  end
end
