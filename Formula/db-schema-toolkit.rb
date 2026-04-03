class DbSchemaToolkit < Formula
  desc "Parse, export, and analyze database schemas from the CLI"
  homepage "https://github.com/maxgfr/db-schema-viewer"
  url "https://registry.npmjs.org/db-schema-toolkit/-/db-schema-toolkit-1.1.1.tgz"
  sha256 "5a49d8f662d26017131a0b0209747e98a7a808ea9a575bab040f8a866dcd2e55"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
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
