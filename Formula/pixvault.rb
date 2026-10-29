class Pixvault < Formula
  desc "Private photo tools: compress, convert HEIC/RAW/AVIF, resize, strip GPS, AI"
  homepage "https://github.com/maxgfr/pixvault"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/pixvault/releases/download/v1.3.3/pixvault-macos-arm64"
      sha256 "2116ed45c467f5b8ba68e3627d453b85e10d97c3b7222ba913de5bd1c0f5246d"
    end

    on_intel do
      url "https://github.com/maxgfr/pixvault/releases/download/v1.3.3/pixvault-macos-x64"
      sha256 "556a1f7f325d45e34f8e4cecc230d2d674ce9cab8f2c02b7a547bb70ef9f0cb0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/pixvault/releases/download/v1.3.3/pixvault-linux-arm64"
      sha256 "fe76a7842c0faebda861638c4c4b4e76266fd369b1cd13b09d7479bdad5adf24"
    end

    on_intel do
      url "https://github.com/maxgfr/pixvault/releases/download/v1.3.3/pixvault-linux-x64"
      sha256 "73d6d511cad46a1f94f816765c39e4206d6b577170dc36a45117668f71cf780e"
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
