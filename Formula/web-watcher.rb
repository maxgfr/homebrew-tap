class WebWatcher < Formula
  desc "Watch APIs & websites for changes — get notified instantly from your terminal"
  homepage "https://github.com/maxgfr/web-watcher"
  url "https://github.com/maxgfr/web-watcher/archive/refs/tags/v1.2.0.tar.gz"
  version "v1.2.0"
  sha256 "e81461abadb30828350c9fd2a43359e0f79d9c4f85b06d7843fa806256beae8d"
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
