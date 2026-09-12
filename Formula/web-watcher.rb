class WebWatcher < Formula
  desc "Watch APIs & websites for changes — get notified instantly from your terminal"
  homepage "https://github.com/maxgfr/web-watcher"
  url "https://github.com/maxgfr/web-watcher/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "43179b0c4e130e890781333028590ead7809a306747b8d223aad93b7d85782f5"
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
