class Conforme < Formula
  desc "Sync AI coding agent configuration from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.9.2/conforme-macos-arm64"
      sha256 "261ad0aa0140c09e8a1139cf43e3151ed51d61977654eedf5f020a5257afda9e"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.9.2/conforme-macos-x64"
      sha256 "4013c4740748498096a5db15e183b9f95391df69cf282c3e1a4c90457ec2679d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v5.9.2/conforme-linux-arm64"
      sha256 "a638b0c7be47e87b2c71a654de4224bb1257cede02f244b80e308c19d69470ad"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v5.9.2/conforme-linux-x64"
      sha256 "7745db7e82871d1f231c70debf54dafd7280e8f079111d8b5931973f0f509c3a"
    end
  end

  def install
    binary = Dir["conforme-*"].first

    if binary.nil?
      opoo "No conforme binary found"
      return
    end

    chmod 0755, binary
    bin.install binary => "conforme"
  end

  test do
    assert_match "conforme", shell_output("#{bin}/conforme --help 2>&1")
  end
end
