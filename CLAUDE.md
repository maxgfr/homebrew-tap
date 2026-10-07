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

### Binary formulas (binance-historical, rshc, llm-models, codexify, scopelet, secretgate, troupe)
- Download pre-compiled binaries per platform from GitHub Releases
- Platform detection: `on_macos do / on_arm do`, `on_intel do`, `on_linux do`

### Source/script formulas (git-recap, snatch, subtool, swarmdeck, etc.)
- Download source tarball from GitHub Releases
- Install scripts directly with `bin.install`

### NPM package formulas (db-schema-toolkit)
- Download from npmjs.org registry
- Require `node` dependency

### Formulas depending on another formula of this tap (web-watcher → webindex)
- Declare it as `depends_on "maxgfr/tap/<name>"` (fully qualified, next to the system deps)
- The update workflow only rewrites `url`/`sha256` (web-watcher has no `version` line: brew audit flags it as redundant with the URL, and the workflow reads the current tag from `url`), so the `depends_on` line survives bumps
- Bump the dependency's own formula first when the dependent needs a newer version of it

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
| 18 | codeindex |
| 19 | sift |
| 20 | webindex |
| 21 | codexify |
| 22 | scopelet |
| 23 | secretgate |
| 0:30 | swarmdeck |
| 1:30 | troupe |

All formulas have an update workflow — never leave one manually updated
(codeindex stayed frozen at v2.6.0 for 7 minor releases because of that).
Note for codeindex: its update workflow must NOT use `releases/latest` — the
repo also publishes the `embed-model-v1` asset release, which is not an
engine tag; filter release tags on `^v[0-9]` instead.

Note for sift: `homebrew/core` ships an unrelated `sift` (a grep alternative),
so the formula carries `conflicts_with "sift"`. Without it Homebrew fails at
link time with nothing the user can act on. sift also publishes a Windows
binary, which Homebrew does not install — the update workflow deliberately
checksums only the four macOS/Linux artifacts.

Note for scopelet: it breaks two tap conventions on purpose. Its release assets
are named by Rust target triple (`scopelet-aarch64-apple-darwin`), not
`<name>-<platform>-<arch>`, and its formula stores the bare `0.5.4` while the
URLs keep the `v0.5.4` tag — `brew style` rejects a leading `v`, so the update
workflow carries both `version` (tag, for URLs) and `number` (bare, for the
formula and the up-to-date check). Comparing the bare version against the tag
would rewrite and commit the formula on every run. The release also publishes
`scopelet.skill` and `SHA256SUMS`, which are not Homebrew artifacts and are not
checksummed.

Note for secretgate: the binaries are Bun-compiled (`bun build --compile`),
so they are large (60–80 MB) and need no Node. The release also publishes
`secretgate.mjs` (the skill's Node bundle) and `SHA256SUMS`, which are not
Homebrew artifacts and are not checksummed. `secretgate init` pins a copy of
the binary under `~/.secretgate/bin`, so the formula's `caveats` tell users to
re-run it after `brew upgrade`.

Note for swarmdeck: every hour slot was taken, so it runs at 00:30. It is a
source formula like snatch: the release's source tarball, with `cli/`, `lib/`,
`mcp/` and `package*.json` installed into `libexec` and `npm ci --omit=dev
--ignore-scripts` run there (only the MCP server has dependencies; the dev ones
are the site's tests). Two commands are written with `write_env_script` so they
run on Homebrew's node: `swarmdeck` and `swarmdeck-mcp`. Like web-watcher it has
no `version` line, and the workflow reads the current tag from `url`. swarmdeck
releases by semantic-release (a release for every feat or fix on its main, with
package.json bumped in the tagged commit), so the formula test's `--version` check
matches the tag.

Note for troupe: like secretgate its binaries are Bun-compiled (60–80 MB, no
Node), the x64 ones on Bun's baseline runtime, the macOS ones re-signed ad
hoc. Like scopelet the formula stores the bare `0.4.0` while the URLs keep the
`v0.4.0` tag, so the workflow carries both `version` (tag) and `number`
(bare). troupe releases by semantic-release (a release for every feat or fix
on its main, the version injected at build time), so the formula test's
`--version` check matches the tag. Its release workflow attaches the binaries
a few minutes after the GitHub Release is published: a run in between fails
its download and the next run updates. The release's other assets
(`troupe-cli-<version>.mjs`, the browser edition zip, `SHA256SUMS`) are not
Homebrew artifacts. The studio itself runs with Docker; the formula's
`caveats` say so.

## Conventions
- Workflow files: `update-<formula-name>.yml`
- Formula class names: PascalCase (e.g., `BinanceHistorical`, `LlmModels`)
- Binary naming: `<name>-<platform>-<arch>` (e.g., `llm-models-macos-arm64`)
- Commit messages: `chore: update <name> to <version>`
- All formulas use MIT license
