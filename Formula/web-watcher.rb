class WebWatcher < Formula
  desc "Watch APIs & websites for changes — get notified instantly from your terminal"
  homepage "https://github.com/maxgfr/web-watcher"
  url "https://github.com/maxgfr/web-watcher/archive/refs/tags/v1.0.3.tar.gz"
  version "v1.0.3"
  sha256 "370cbae4946bf06c613127247272789dc8eb5871bcfe00d7238fe0b54fe09a6f"
  license "MIT"

  depends_on "curl"
  depends_on "jq"

  def install
    bin.install "script.sh" => "web-watcher"
  end

  test do
    system "#{bin}/web-watcher", "--version"
  end
end
