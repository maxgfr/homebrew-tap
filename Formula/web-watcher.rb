class WebWatcher < Formula
  desc "Watch APIs & websites for changes — get notified instantly from your terminal"
  homepage "https://github.com/maxgfr/web-watcher"
  url "https://github.com/maxgfr/web-watcher/archive/refs/tags/v1.0.1.tar.gz"
  version "v1.0.1"
  sha256 "732ec6b2c8a6902ab623d1688f72c4857e94bd91f62041b1139081ff2bbce60f"
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
