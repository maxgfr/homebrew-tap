# AGENTS.md

## Project overview
Personal Homebrew tap for maxgfr's CLI tools. Each formula distributes pre-compiled
binaries or shell scripts from their respective GitHub repos.

## RULE: docs stay in sync — every time

Every formula change (add, rename, remove, or new pattern) MUST update, in the
same commit:
- `README.md` — the formula's entry (link, description, install + usage example)
- this `AGENTS.md` — the cron table and, if relevant, the Patterns section

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

### 3. Update README.md and AGENTS.md (mandatory, same commit)

Add the new formula entry to README.md in alphabetical or logical order with:
- Link to source repo
- One-line description
- `brew install` and usage example

Then update this AGENTS.md: add the formula to the cron table (or to the
"manually updated" list if it has no workflow) and to Patterns if it
introduces a new one.

## Patterns

### Binary formulas (binance-historical, rshc, llm-models, codexify, scopelet, secretgate, troupe, veil, pdfvault, aparte, nuee, obscura, hush, termrevive)
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
| 2:30 | veil |
| 3:30 | pdfvault |
| 4:30 | aparte |
| 5:30 | nuee |
| 6:30 | obscura |
| 7:30 | hush |
| 8:30 | termrevive |

All formulas have an update workflow — never leave one manually updated
(codeindex stayed frozen at v2.6.0 for 7 minor releases because of that).
Note for codeindex: its update workflow must NOT use `releases/latest` — the
repo also publishes the `embed-model-v1` asset release, which is not an
engine tag; filter release tags on `^v[0-9]` instead.

Note for llm-models: the maxgfr/llm-models repo also releases its
`llm-connect` library as `llm-connect-v*` tags, which carry no llm-models
binary and are often the repo's latest release. The update workflow must NOT
use `releases/latest`: it picks the newest `^v[0-9]` release, and downloads
with `curl -f` so a missing asset fails the run instead of checksumming a 404
page (the formula once shipped `llm-connect-v2.0.0` with the 404's digest on
every platform). Like aparte, the formula has no `version` line (brew scans
`1.12.0` from the `v1.12.0` URLs; a `version "v…"` line fails `brew style`), and
the workflow reads the current tag from the first `url`.

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
hoc. Like web-watcher it has no `version` line (brew audit flags it as
redundant with the URLs' `v0.4.0`), and the workflow reads the current tag
from the first `url`. troupe releases by semantic-release (a release for every feat or fix
on its main, the version injected at build time), so the formula test's
`--version` check matches the tag. Its release workflow attaches the binaries
a few minutes after the GitHub Release is published: a run in between fails
its download and the next run updates. The release's other assets
(`troupe-cli-<version>.mjs`, the browser edition zip, `SHA256SUMS`) are not
Homebrew artifacts. The studio itself runs with Docker; the formula's
`caveats` say so.

Note for veil: the maxgfr/veil repo is a web app plus a Rust CLI, and only its
`cli-v*` tags are CLI releases, so the update workflow picks the newest
`^cli-v[0-9]` release instead of `releases/latest`. Like scopelet, assets are
named by Rust target triple (`veil-aarch64-apple-darwin`) and the formula keeps
the bare `0.1.0` while the URLs keep the `cli-v0.1.0` tag (`version` = tag for
URLs, `number` = bare for the formula and the up-to-date check). The release's
`SHA256SUMS` is not a Homebrew artifact. The formula test runs `veil new`,
which prints a room link offline.

Note for pdfvault: like troupe its binaries are Bun-compiled (about 95 MB:
the wasm engine and the 12 MB of OCR models are embedded, no Node or Bun
needed), the x64 ones on Bun's baseline runtime, the macOS ones re-signed ad
hoc on a macOS runner. Like troupe it has no `version` line and the workflow
reads the current tag from the first `url`. pdfvault releases by
semantic-release (a release for every feat or fix on its main, the version
stamped at build time), so the formula test's `--version` check matches the
tag. Its release workflow attaches the binaries a few minutes after the
GitHub Release is published: a run in between fails its download and the next
run updates. The release's Windows binaries and `SHA256SUMS` are not Homebrew
artifacts. The formula test writes a one-page PDF and rotates it offline,
and checks `pdfvault skill` prints the agent skill; `caveats` point to
`npx skills add maxgfr/pdfvault` (the CLI no longer installs the skill itself).

Note for aparte and nuee: Rust CLIs released like veil, with assets named by
Rust target triple (`aparte-aarch64-apple-darwin`) and a `SHA256SUMS` that is
not a Homebrew artifact, but tagged `v*` (`v1.2.0`). brew scans the version
from those URLs, so like troupe the formulas have no `version` line (brew
audit flags it as redundant) and the workflows read the current tag from the
first `url`; they pick the newest `^v[0-9]` release rather than
`releases/latest`. Both formula tests are offline: `aparte selftest` (plain and
`--json`), and `nuee selftest` plus `nuee id` run twice against a config dir in
`testpath`, which must create the identity key once and print the same id. The
aparte CLI has no vault command yet, so its test has no vault round trip.
nuee is dual-licensed: `license any_of: ["MIT", "Apache-2.0"]`.

Note for obscura: the maxgfr/obscura repo is a web app plus a Rust CLI released
exactly like veil: only its `cli-v*` tags are CLI releases (the workflow picks
the newest `^cli-v[0-9]` release), assets are named by Rust target triple
(`obscura-aarch64-apple-darwin`), `SHA256SUMS` is not a Homebrew artifact, and
the formula has no `version` line (brew scans it from the `cli-v…` URLs; the
workflow reads the current one back from the first `url`). Like sift, it
carries `conflicts_with "obscura"`: homebrew-core ships an unrelated `obscura`
(a headless browser) with the same binary name, so users install it as
`maxgfr/tap/obscura`. The formula test is offline: `obscura new` prints a
studio link (`…/obscura/#s=…`) and `obscura selftest` runs a seal/open round
trip, a wrong-passphrase refusal and a link round trip.

Note for hush: the maxgfr/hush repo is a web app plus a Rust CLI released
exactly like veil and obscura: only its `cli-v*` tags are CLI releases (the
workflow picks the newest `^cli-v[0-9]` release), assets are named by Rust
target triple (`hush-aarch64-apple-darwin`), `SHA256SUMS` is not a Homebrew
artifact, and the formula has no `version` line (brew scans it from the
`cli-v…` URLs; the workflow reads the current one back from the first `url`).
homebrew-cask ships an unrelated `hush` app (a Safari content blocker), with no
binary in common, so there is no `conflicts_with`; the README tells users to
install `maxgfr/tap/hush` by its full name. The formula test is offline:
`hush new` prints a link (`…/hush/#<version>.s.<43 chars>.<expiry>`, version 1 or later).

Note for termrevive: a macOS-only Rust CLI (it drives Ghostty through
AppleScript and reads the macOS process table), so the formula has
`depends_on :macos` and only an `on_macos` block, and the workflow checksums the
two macOS artifacts. Otherwise it is released like aparte: `v*` tags by
semantic-release, assets named by Rust target triple
(`termrevive-aarch64-apple-darwin`), a `SHA256SUMS` that is not a Homebrew
artifact, no `version` line (the workflow reads the current tag from the first
`url`). The formula test is offline: `--version`, and `termrevive list` against
an empty `XDG_STATE_HOME` in `testpath` prints `no snapshot yet` without touching
any terminal, and `termrevive skill` prints the bundled agent skill. `caveats`
name the supported terminals and coding agents and point to `termrevive doctor --fix` (the settings Ghostty, iTerm2, kitty and
Terminal.app need for a restore) and to `npx skills add maxgfr/termrevive`.

## Conventions
- Workflow files: `update-<formula-name>.yml`
- Formula class names: PascalCase (e.g., `BinanceHistorical`, `LlmModels`)
- Binary naming: `<name>-<platform>-<arch>` (e.g., `llm-models-macos-arm64`)
- Commit messages: `chore: update <name> to <version>`
- All formulas use MIT license (nuee: MIT or Apache-2.0)
