class LeboncoinCdp < Formula
  desc "Manage Leboncoin listings from markdown and publish them via your browser"
  homepage "https://github.com/maxgfr/leboncoin-cdp"
  url "https://github.com/maxgfr/leboncoin-cdp/archive/refs/tags/v1.7.1.tar.gz"
  sha256 "5bfc1970b9317ecff2a4a5160311d7ccdd91178193695d9dc3e91561851c3532"
  license "MIT"

  depends_on "node"

  def install
    # scripts/leboncoin.mjs is a zero-dependency bundle: no npm install. It finds the
    # bundled example annonce at ../assets/example-annonce, relative to itself.
    libexec.install "scripts", "assets", "references", "SKILL.md"
    env = { PATH: "#{formula_opt_bin("node")}:$PATH" }
    (bin/"leboncoin").write_env_script libexec/"scripts/leboncoin.mjs", env
  end

  def caveats
    <<~EOS
      The scraper and the CDP commands (login, doctor, inspect, publish, comparables)
      drive a Chromium-based browser. Install one of:
        brew install --cask google-chrome
        brew install --cask brave-browser
      Agent skill: npx skills add maxgfr/leboncoin-cdp
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/leboncoin --version").strip
    assert_match "leboncoin validate <slug>", shell_output("#{bin}/leboncoin --help")
    # Offline: the bundled example annonce passes the structural gate.
    assert_match "example-annonce: valid",
                 shell_output("#{bin}/leboncoin validate example-annonce --annonces-dir #{libexec}/assets")
  end
end
