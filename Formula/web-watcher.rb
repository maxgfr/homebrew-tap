class WebWatcher < Formula
  desc "Watch APIs & websites for changes — get notified instantly from your terminal"
  homepage "https://github.com/maxgfr/web-watcher"
  url "https://github.com/maxgfr/web-watcher/archive/refs/tags/v1.1.1.tar.gz"
  version "v1.1.1"
  sha256 "e50582bbbc7bb358369155248ace6e7dd2dc638554c404a45a5ba6df9c57eb87"
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
