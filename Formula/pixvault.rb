class Pixvault < Formula
  desc "Private photo tools: compress, convert HEIC/RAW/AVIF, resize, strip GPS, AI"
  homepage "https://github.com/maxgfr/pixvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pixvault/releases/download/v1.3.2/pixvault-macos-arm64"
      sha256 "86216166361606248fe3421c298279285926bd06fda16af060f2afe5ca924457"
    end

    on_intel do
      url "https://github.com/maxgfr/pixvault/releases/download/v1.3.2/pixvault-macos-x64"
      sha256 "fb46554584b0c5e10bdbc08914aa4ed64a10e5ff81c3b86f9fb06152077c2657"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pixvault/releases/download/v1.3.2/pixvault-linux-arm64"
      sha256 "cce37d93ff34807851ce226ad67091fb7a64e6fc75cc57a69c7522be24a83179"
    end

    on_intel do
      url "https://github.com/maxgfr/pixvault/releases/download/v1.3.2/pixvault-linux-x64"
      sha256 "fef7bcaaaf99b48ee85b444d0685d5e198e2fcad4df05870bd9f20905cdda7c0"
    end
  end

  def install
    binary = Dir["pixvault-*"].first
    odie "No pixvault binary found" if binary.nil?

    chmod 0755, binary
    bin.install binary => "pixvault"
  end

  def caveats
    <<~EOS
      The AI tools (remove-bg, upscale, blur-faces, erase, describe, smart-crop)
      download their model once, checked against its SHA-256, into
      #{OS.mac? ? "~/Library/Caches/pixvault" : "~/.cache/pixvault"} (PIXVAULT_CACHE overrides it).
      `pixvault models` lists and removes them. Nothing else touches the network.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/pixvault --version").strip
    # Offline: a 4×3 PNG converted to JPEG, then read back.
    png = "iVBORw0KGgoAAAANSUhEUgAAAAQAAAADCAIAAAA7ljmRAAAAEElEQVR4nGM4YaMBRww4OQAZ7g4RX8PtlgAAAABJRU5ErkJggg=="
    (testpath/"in.png").binwrite(png.unpack1("m"))
    system bin/"pixvault", "convert", "--to", "jpeg", testpath/"in.png", "-o", testpath, "--quiet"
    info = shell_output("#{bin}/pixvault inspect --json #{testpath}/in.jpg")
    assert_match '"format": "jpeg"', info
    assert_match '"width": 4', info
  end
end
