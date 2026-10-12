class WebWatcher < Formula
  desc "Watch APIs & websites for changes — get notified instantly from your terminal"
  homepage "https://github.com/maxgfr/web-watcher"
  url "https://github.com/maxgfr/web-watcher/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "30708a38df5317247987a7ba9bbd6b409afa6da022876f4768d5cb55628bade2"
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
