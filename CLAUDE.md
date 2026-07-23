# CLAUDE.md

## Project overview
Personal Homebrew tap for maxgfr's CLI tools. Each formula distributes pre-compiled
binaries or shell scripts from their respective GitHub repos.

## RULE: docs stay in sync — every time

Every formula change (add, rename, remove, or new pattern) MUST update, in the
same commit:
- `README.md` — the formula's entry (link, description, install + usage example)
- this `CLAUDE.md` — the cron table and, if relevant, the Patterns section

No exceptions. `codeindex` was added (v2.0.1) without its README entry and
without updating this file — that gap is exactly what this rule prevents.

## How to add a new formula

### 1. Create the GitHub Actions workflow

Create `.github/workflows/update-<name>.yml` with:
- Cron schedule (pick a free UTC hour slot, check existing workflows)
- `workflow_dispatch` for manual trigger
- Steps: get latest release, download binaries, calculate SHA256, check if update needed, update formula, commit & push
- Use `GHTOKEN` secret for GitHub API calls
- Use `GITHUB_TOKEN` for git push

### 2. Create the Formula

Create `Formula/<name>.rb` with:
- `desc`, `homepage`, `version`, `license`
- Platform-specific blocks: `on_macos` (arm/intel), `on_linux` (arm/intel)
- Each block has `url` pointing to release binary and `sha256` checksum
- `install` method: find binary, chmod, `bin.install`
- `test` block: verify `--version` or `--help`

### 3. Update README.md and CLAUDE.md (mandatory, same commit)

Add the new formula entry to README.md in alphabetical or logical order with:
- Link to source repo
- One-line description
- `brew install` and usage example

Then update this CLAUDE.md: add the formula to the cron table (or to the
"manually updated" list if it has no workflow) and to Patterns if it
introduces a new one.

## Patterns

### Binary formulas (binance-historical, rshc, llm-models)
- Download pre-compiled binaries per platform from GitHub Releases
- Platform detection: `on_macos do / on_arm do`, `on_intel do`, `on_linux do`

### Source/script formulas (git-recap, snatch, subtool, etc.)
- Download source tarball from GitHub Releases
- Install scripts directly with `bin.install`

### NPM package formulas (db-schema-toolkit)
- Download from npmjs.org registry
- Require `node` dependency

## Cron schedule (UTC)

| Hour | Formula |
|------|---------|
| 0 | binance-historical |
| 1 | copyable-pdf |
| 2 | package-checker |
| 3 | web-watcher |
| 4 | ratio-master |
| 5 | snatch |
| 6 | subtool |
| 7 | git-pilot |
| 8 | git-recap |
| 9 | rshc |
| 10 | db-schema-toolkit |
| 11 | claude-code-switch |
| 12 | github-helpers |
| 13 | llm-models |
| 14 | conforme |
| 15 | andro |
| 16 | claudfeine |
| 17 | codexfeine |

Manually updated (no workflow): **codeindex** — source-tarball formula
(`depends_on "node"`, installs prebuilt `engine.mjs`/`cli.mjs` + grammar
sidecar); bump `url`/`sha256`/`version` on each release
(`feat: bump codeindex to vX.Y.Z`).

## Conventions
- Workflow files: `update-<formula-name>.yml`
- Formula class names: PascalCase (e.g., `BinanceHistorical`, `LlmModels`)
- Binary naming: `<name>-<platform>-<arch>` (e.g., `llm-models-macos-arm64`)
- Commit messages: `chore: update <name> to <version>`
- All formulas use MIT license
