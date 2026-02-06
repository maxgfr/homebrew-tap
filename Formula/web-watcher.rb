class WebWatcher < Formula
  desc "Watch APIs & websites for changes — get notified instantly from your terminal"
  homepage "https://github.com/maxgfr/web-watcher"
  url "https://github.com/maxgfr/web-watcher/archive/refs/tags/v1.0.0.tar.gz"
  version "v1.0.0"
  sha256 "065df0edd34f48e9926ae2f48e527811988b364b907b8f8d1b21d36799b17067"
  license "MIT"

  depends_on "curl"
  depends_on "jq" => :recommended

  def install
    bin.install "script.sh" => "web-watcher"
  end

  test do
    system "#{bin}/web-watcher", "--version"
  end
end
