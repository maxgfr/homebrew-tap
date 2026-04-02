class DbSchema < Formula
  desc "Parse, export, and analyze database schemas from the CLI"
  homepage "https://github.com/maxgfr/db-schema-viewer"
  url "https://registry.npmjs.org/db-schema-toolkit/-/db-schema-toolkit-1.0.0.tgz"
  sha256 "e1e1d8aa4d3ee88b6754dfdd0507e1256447f1ef1b18cf34221418217d88890a"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system bin/"db-schema", "help"

    # Test parsing a simple SQL schema
    (testpath/"schema.sql").write <<~SQL
      CREATE TABLE users (
        id SERIAL PRIMARY KEY,
        email VARCHAR(255) NOT NULL
      );
    SQL
    output = shell_output("#{bin}/db-schema info #{testpath}/schema.sql")
    assert_match "Tables: 1", output
    assert_match "users", output
  end
end
