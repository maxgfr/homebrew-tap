class Pixvault < Formula
  desc "Private photo tools: compress, convert HEIC/RAW/AVIF, resize, strip GPS, AI"
  homepage "https://github.com/maxgfr/pixvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pixvault/releases/download/v1.3.1/pixvault-macos-arm64"
      sha256 "cec6d611f84f62294e6c590e0210e96453936f4470b81abf625d28a6d4469a66"
    end

    on_intel do
      url "https://github.com/maxgfr/pixvault/releases/download/v1.3.1/pixvault-macos-x64"
      sha256 "8e81940a2cd93b02b6f7784becea59d5824f325436f064e90e8fc110be0ad885"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pixvault/releases/download/v1.3.1/pixvault-linux-arm64"
      sha256 "46dfae5ec97fd19a3207e0f3a961ab763b98885857c14f5954323ab4124aeb85"
    end

    on_intel do
      url "https://github.com/maxgfr/pixvault/releases/download/v1.3.1/pixvault-linux-x64"
      sha256 "56ce04d234e22f0f0f524e8d33dab52508e4a871d0a5821ad023ef0deeed8c43"
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
