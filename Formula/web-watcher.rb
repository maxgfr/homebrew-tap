class WebWatcher < Formula
  desc "Watch APIs & websites for changes — get notified instantly from your terminal"
  homepage "https://github.com/maxgfr/web-watcher"
  url "https://github.com/maxgfr/web-watcher/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "c94c6be7c4ed01e9f711d9b105ecfa3d8638f5fe2c36bc0bb9ba5748e643f0e1"
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
