class DbSchemaToolkit < Formula
  desc "Parse, export, and analyze database schemas from the CLI"
  homepage "https://github.com/maxgfr/db-schema-viewer"
  url "https://registry.npmjs.org/db-schema-toolkit/-/db-schema-toolkit-1.1.8.tgz"
  sha256 "c02688ac8305082b8eef7c01a3fc49899a0a1d08f38b15b838b51a6033297a8d"
  license "MIT"

  depends_on "node"

  def install
    # cli.js is a self-contained bundle (all deps inlined by tsup)
    # so we just need to copy it — no npm install required
    bin.install "dist/cli.js" => "db-schema-toolkit"
  end

  test do
    system bin/"db-schema-toolkit", "help"

    # Test parsing a simple SQL schema
    (testpath/"schema.sql").write <<~SQL
      CREATE TABLE users (
        id SERIAL PRIMARY KEY,
        email VARCHAR(255) NOT NULL
      );
    SQL
    output = shell_output("#{bin}/db-schema-toolkit info #{testpath}/schema.sql")
    assert_match "Tables: 1", output
    assert_match "users", output
  end
end
