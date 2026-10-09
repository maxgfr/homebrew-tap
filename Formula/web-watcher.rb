class WebWatcher < Formula
  desc "Watch APIs & websites for changes — get notified instantly from your terminal"
  homepage "https://github.com/maxgfr/web-watcher"
  url "https://github.com/maxgfr/web-watcher/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "da2381d75085bd03c465b2af3ce2a1815a8b2a0fc56b421a479e20f52e346179"
  license "MIT"

  depends_on "curl"
  depends_on "jq"
  # Website mode hands HTML to `webindex extract` when it is installed.
  depends_on "maxgfr/tap/webindex"

  def install
    bin.install "script.sh" => "web-watcher"
  end

  test do
    system bin/"web-watcher", "--version"
    assert_match "--ignore", shell_output("#{bin}/web-watcher --help")
  end
end
