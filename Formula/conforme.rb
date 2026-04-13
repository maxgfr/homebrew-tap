class Conforme < Formula
  desc "Universal AI coding agent config synchronization — sync from any tool to all others"
  homepage "https://github.com/maxgfr/conforme"
  version "v1.8.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.8.2/conforme-macos-arm64"
      sha256 "22ec32c90a9f75e8ade0887aaf45cc597dbab0fe76f663a83ba4ac015b8de2f2"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.8.2/conforme-macos-x64"
      sha256 "ee55b3e2ae8153aa98905f317693dd452110c375a199a3350713cb60c8bbde63"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/maxgfr/conforme/releases/download/v1.8.2/conforme-linux-arm64"
      sha256 "23897f81f8a6c70c1e1e2372fc87b0796c1cbee98eb8c2ac0a69be671859d73c"
    end

    on_intel do
      url "https://github.com/maxgfr/conforme/releases/download/v1.8.2/conforme-linux-x64"
      sha256 "fce9a597584e088c43159b210cfebe5e53ea12b9b09517095d0424cad47d68f7"
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
