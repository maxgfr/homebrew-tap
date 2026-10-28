class Pixvault < Formula
  desc "Private photo tools: compress, convert HEIC/RAW/AVIF, resize, strip GPS, AI"
  homepage "https://github.com/maxgfr/pixvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pixvault/releases/download/v1.3.0/pixvault-macos-arm64"
      sha256 "075f499357681ca27d4767769b6ffdce8b3edf10aee2a34efaa59d0f92e81cb1"
    end

    on_intel do
      url "https://github.com/maxgfr/pixvault/releases/download/v1.3.0/pixvault-macos-x64"
      sha256 "e027932101ad4d2ddbcc504b2bacf72ecdbac0594b2fc758c03cfc0178b94292"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pixvault/releases/download/v1.3.0/pixvault-linux-arm64"
      sha256 "9bf342fc6f76f9425c8438ee19d33740db94b81aee173fb97812f5957ea5888f"
    end

    on_intel do
      url "https://github.com/maxgfr/pixvault/releases/download/v1.3.0/pixvault-linux-x64"
      sha256 "50899a3b969c0586999badf82dcd43e196ec56353f5834f8f0658f911d1447dd"
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
