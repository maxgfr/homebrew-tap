# Homebrew Tap

Personal Homebrew tap for [@maxgfr](https://github.com/maxgfr)'s projects.

## Contents

- [Installation](#installation)
- [Formulae](#formulae)
  - [AI agents and LLM tooling](#ai-agents-and-llm-tooling)
  - [Git and GitHub](#git-and-github)
  - [Private files and messaging](#private-files-and-messaging)
  - [PDF, image and video](#pdf-image-and-video)
  - [Torrents](#torrents)
  - [Developer tools](#developer-tools)
  - [Data and monitoring](#data-and-monitoring)
- [Uninstalling](#uninstalling)

## Installation

```bash
brew tap maxgfr/tap
brew install maxgfr/tap/<formula>
```

## Formulae

### AI agents and LLM tooling

#### [claude-code-switch](https://github.com/maxgfr/claude-code-switch)

Switch Claude Code between Anthropic, OpenRouter and other API providers

**Note:** installs the `ccs` command. Supports Anthropic, OpenRouter, DeepSeek, Gemini, Mistral, OpenAI and custom endpoints.

```bash
brew install maxgfr/tap/claude-code-switch
ccs --help
```

#### [claudfeine](https://github.com/maxgfr/claudfeine)

Keep your machine awake for the duration of a Claude Code session

```bash
brew install maxgfr/tap/claudfeine
claudfeine --continue
```

#### [codeindex](https://github.com/maxgfr/codeindex)

Index the symbols, imports, callers and link graph of a repo, with MCP server

**Note:** also on [npm](https://www.npmjs.com/package/@maxgfr/codeindex).

```bash
brew install maxgfr/tap/codeindex
codeindex index --repo . --out .codeindex
```

#### [codexfeine](https://github.com/maxgfr/claudfeine)

Keep your machine awake for the duration of an OpenAI Codex session

```bash
brew install maxgfr/tap/codexfeine
codexfeine
```

#### [codexify](https://github.com/maxgfr/codexify)

Manage Codex profiles, notifications, config backups and keep-awake sessions

```bash
brew install maxgfr/tap/codexify
codexify doctor
codexify notify on
```

#### [conforme](https://github.com/maxgfr/conforme)

Sync AI coding agent configuration from any tool to all others

```bash
brew install maxgfr/tap/conforme
conforme --help
```

#### [llm-models](https://github.com/maxgfr/llm-models)

Find, compare and price LLM models from OpenRouter and models.dev

```bash
brew install maxgfr/tap/llm-models
llm-models find -C reasoning --sort cost_input -n 10
```

#### [scopelet](https://github.com/maxgfr/scopelet)

Replace oversized agent command output with local, recoverable bounded views

**Note:** Homebrew installs the binary only. `scopelet install` copies it to `~/.config/scopelet/bin` and points the hooks at that copy, so re-run it after `brew upgrade scopelet`. The model-invocable skill is a separate install: `npx skills add maxgfr/scopelet --skill scopelet --global -a codex claude-code opencode -y`.

```bash
brew install maxgfr/tap/scopelet
scopelet install --agent all   # hooks for Claude Code, Codex and OpenCode
scopelet doctor                # binary, mode and hooks_configured per host
```

#### [secretgate](https://github.com/maxgfr/secretgate)

Redact secrets locally before they reach Claude Code, Codex or OpenCode

**Note:** `secretgate init` copies the binary to `~/.secretgate/bin` and points the hooks at that copy, so re-run it after `brew upgrade secretgate`. The skill is a separate install: `npx skills add maxgfr/secretgate -g`.

```bash
brew install maxgfr/tap/secretgate
secretgate init                # detect the agents, wire their hooks, self-test them
secretgate scan .              # exit 1 on findings
```

#### [sift](https://github.com/maxgfr/sift)

Check whether an LLM fits and runs fast on your machine before downloading it

**Note:** `homebrew/core` ships an unrelated `sift` (a grep alternative), so install this one tap-qualified. The two cannot be linked at the same time.

```bash
brew install maxgfr/tap/sift
sift fit unsloth/Qwen3-30B-A3B-GGUF
```

#### [webindex](https://github.com/maxgfr/webindex)

Extract clean text from URLs, PDFs and office files, with an MCP server

```bash
brew install maxgfr/tap/webindex
webindex fetch https://example.com
webindex extract report.pdf
webindex mcp                      # serve fetch/extract to an agent over stdio
webindex doctor                   # which rungs and helpers are available here
```

### Git and GitHub

#### [git-pilot](https://github.com/maxgfr/git-pilot)

Automate git with AI-written commits, conflict resolution and auto-rebase

```bash
brew install maxgfr/tap/git-pilot
git-pilot --help
```

#### [git-recap](https://github.com/maxgfr/git-recap)

Generate monthly commit recaps with AI summaries and bullet points

```bash
brew install maxgfr/tap/git-recap
git-recap --help
```

#### [github-helpers](https://github.com/maxgfr/github-helpers)

Bulk-unstar repos, clone whole orgs and run other GitHub maintenance tasks

```bash
brew install maxgfr/tap/github-helpers
github-helpers --help
```

### Private files and messaging

#### [aparte](https://github.com/maxgfr/aparte)

Read and write the encrypted Aparté AI chat format from the terminal

**Web app:** <https://maxgfr.github.io/aparte/>

```bash
brew install maxgfr/tap/aparte
aparte selftest                               # offline check of the format and crypto
aparte doctor                                 # this machine and the directories in use
```

#### [hush](https://github.com/maxgfr/hush)

Chat and transfer files with post-quantum end-to-end encryption

**Web app:** <https://maxgfr.github.io/hush/>

**Note:** homebrew-cask has an unrelated `hush` app, so install this one by its full name.

```bash
brew install maxgfr/tap/hush
hush chat                                     # prints a link and a QR code, then chat (/ok to confirm the emojis)
hush send report.pdf                          # exits once the file is delivered
hush receive 'https://maxgfr.github.io/hush/#…' --out ~/Downloads
hush backup inspect hush-backup.hush
```

#### [nubes](https://github.com/maxgfr/nubes)

Sync a folder with a GitHub repository you own

**Web app:** <https://maxgfr.github.io/nubes/>

```bash
brew install maxgfr/tap/nubes
nubes login                          # fine-grained token: Contents read/write on the repo
cd ~/Documents/cloud && nubes init you/nubes-files
nubes sync                           # or: nubes watch, to keep syncing
nubes log notes.md && nubes restore notes.md --at <commit>
```

#### [nuee](https://github.com/maxgfr/nuee)

Share compute, files and hosting over a private short-lived cloud from one link

**Web app:** <https://maxgfr.github.io/nuee/>

```bash
brew install maxgfr/tap/nuee
nuee share ./photos                           # prints a link, encrypted, until Ctrl-C
nuee get 'https://maxgfr.github.io/nuee/#…'
nuee selftest                                 # offline self-check
```

#### [otpx](https://github.com/maxgfr/otpx)

Generate 2FA codes in the terminal and browser from one encrypted synced vault

**Web app:** <https://maxgfr.github.io/otpx/>

```bash
brew install maxgfr/tap/otpx
otpx init                                    # master password + recovery code
otpx import google-export.png                # Google Authenticator transfer QR codes
otpx sync setup github --repo you/otpx-vault
otpx code github --copy                      # copied, cleared after 20 s
otpx                                         # interactive view
```

#### [veil](https://github.com/maxgfr/veil)

Transfer files and chat peer-to-peer with end-to-end encryption in Veil rooms

**Web app:** <https://maxgfr.github.io/veil/>

```bash
brew install maxgfr/tap/veil
veil send report.pdf                          # prints a room link and a QR code
veil receive 'https://maxgfr.github.io/veil/#…' --out ~/Downloads
```

### PDF, image and video

#### [copyable-pdf](https://github.com/maxgfr/copyable-pdf)

Make PDF text copyable by adding a Tesseract OCR layer

```bash
brew install maxgfr/tap/copyable-pdf
copyable-pdf --help
```

#### [obscura](https://github.com/maxgfr/obscura)

Decrypt, check and repair recordings from the obscura web studio

**Web app:** <https://maxgfr.github.io/obscura/>

**Note:** homebrew-core has an unrelated `obscura` (a headless browser), so install this one by its full name.

```bash
brew install maxgfr/tap/obscura
obscura decrypt obscura-20261021-143005.mp4.obscura   # asks for the passphrase (or OBSCURA_PASSPHRASE)
obscura inspect cut.mp4 && obscura repair cut.mp4     # after a crash or a closed tab
obscura selftest                                     # offline self-check
```

#### [pdfvault](https://github.com/maxgfr/pdfvault)

Compress, merge, split, OCR, protect and convert PDFs and images locally

**Web app:** <https://maxgfr.github.io/pdfvault/>

```bash
brew install maxgfr/tap/pdfvault
pdfvault compress report.pdf --preset strong   # → report-compressed.pdf
pdfvault ocr scan.pdf && pdfvault to-md scan-searchable.pdf
npx skills add maxgfr/pdfvault                 # the agent skill, for any agent (Claude Code, Codex, OpenCode…)
```

#### [pixvault](https://github.com/maxgfr/pixvault)

Compress, convert, resize and strip GPS from photos locally, with AI tools

**Web app:** <https://maxgfr.github.io/pixvault/>

**Note:** AI models download once, verified by SHA-256.

```bash
brew install maxgfr/tap/pixvault
pixvault compress --quality 75 --format webp photos/ -o small/
pixvault convert --to jpeg IMG_0042.HEIC
pixvault strip --remove gps *.jpg -o shared/
pixvault remove-bg product.jpg
```

#### [snatch](https://github.com/maxgfr/snatch)

Download videos with yt-dlp and a CDP browser fallback

```bash
brew install maxgfr/tap/snatch
snatch --help
```

#### [subtool](https://github.com/maxgfr/subtool)

Download, translate, sync and fix subtitles

```bash
brew install maxgfr/tap/subtool
subtool --help
```

#### [troupe](https://github.com/maxgfr/troupe)

Drive a self-hosted Troupe studio for AI actor videos from the terminal

**Note:** the studio itself is not installed here. Run it with Docker (see the repo's quick start), then point the CLI at it with `troupe login --url`.

```bash
brew install maxgfr/tap/troupe
troupe login --url http://localhost:3100
troupe doctor && troupe open
```

#### [verbatim](https://github.com/maxgfr/verbatim)

Transcribe and edit video and audio locally with Parakeet, Canary and ffmpeg

**Web app:** <https://maxgfr.github.io/verbatim/>

```bash
brew install maxgfr/tap/verbatim
verbatim transcribe talk.mp4 -o talk.srt
verbatim cut talk.mp4 --delete 15:39-15:43 --delete-last 5:42 -o short.mp4 --dry-run
npx skills add maxgfr/verbatim                 # the agent skill, for any agent (Claude Code, Codex, OpenCode…)
```

### Torrents

#### [ratio-master](https://github.com/maxgfr/ratio-master)

Manage torrent ratios by sending real HTTP announce requests to trackers

```bash
brew install maxgfr/tap/ratio-master
ratio-master --help
```

#### [swarmdeck](https://github.com/maxgfr/swarmdeck)

Drive a Swarmdeck torrent server and edit .torrent files from the CLI or MCP

**Note:** the server itself is not installed here. Run it with `npm run local` in a checkout of the repo, or as its Docker image, and point `SWARMDECK_URL` (default `http://127.0.0.1:8080`) and `SWARMDECK_TOKEN` at it.

```bash
brew install maxgfr/tap/swarmdeck
swarmdeck add 'magnet:?xt=urn:btih:…' && swarmdeck list
npx skills add maxgfr/swarmdeck                # the agent skill, for any agent
claude mcp add swarmdeck -- swarmdeck-mcp      # the MCP server (or: codex / opencode mcp add swarmdeck -- swarmdeck-mcp)
```

### Developer tools

#### [andro](https://github.com/maxgfr/andro)

Run Android apps from the macOS terminal on a disposable native emulator

**Note:** macOS only (Apple Silicon, native HVF). Runs phone and smart TV apps.

```bash
brew install maxgfr/tap/andro
andro run app.apk
```

#### [db-schema-toolkit](https://github.com/maxgfr/db-schema-viewer)

Parse, export and analyze database schemas from the terminal

```bash
brew install maxgfr/tap/db-schema-toolkit
db-schema-toolkit help
```

#### [package-checker](https://github.com/maxgfr/package-checker.sh)

Detect vulnerable npm packages with a lightweight shell script

```bash
brew install maxgfr/tap/package-checker
package-checker --help
```

#### [rshc](https://github.com/maxgfr/rshc)

Encrypt shell scripts into compiled binaries (Rust reimplementation of SHC)

```bash
brew install maxgfr/tap/rshc
rshc --help
```

#### [termrevive](https://github.com/maxgfr/termrevive)

Save and restore terminal sessions and their running programs across reboots

**Note:** macOS only. Supports Ghostty 1.3+, iTerm2, kitty and Terminal.app; optional LaunchAgents save every 2 minutes and restore at login.

```bash
brew install maxgfr/tap/termrevive
termrevive save        # snapshot now
termrevive show        # what a restore would run
termrevive doctor --fix  # once: terminal settings restores need
termrevive restore     # after a reboot, from a fresh Ghostty window
termrevive install     # optional: auto-save + auto-restore at login
npx skills add maxgfr/termrevive   # agent skill for Claude Code, Codex…
```

### Data and monitoring

#### [binance-historical](https://github.com/maxgfr/binance-historical)

Download historical klines from the Binance API as JSON or CSV

```bash
brew install maxgfr/tap/binance-historical
binance-historical download --help
```

#### [crible](https://github.com/maxgfr/crible)

Screen stocks on fundamentals with a self-hosted CLI, API and MCP server

**Note:** the first install builds its Python environment from the release's locked dependencies (a few minutes, once per version).

```bash
brew install maxgfr/tap/crible
crible --data-dir ~/crible bootstrap                                   # the published dataset
crible --data-dir ~/crible screen "piotroski_f >= 7 AND region = 'europe'"
crible --data-dir ~/crible stats --symbol MC.PA roic gross_margin      # where it sits among its peers
crible --data-dir ~/crible mcp                                         # MCP server over stdio
```

#### [web-watcher](https://github.com/maxgfr/web-watcher)

Watch APIs and websites for changes and get notified in the terminal

**Note:** depends on `webindex` (installed automatically), which website mode uses as its HTML-to-text extractor.

```bash
brew install maxgfr/tap/web-watcher
web-watcher --help
# Watch a page, ignoring the lines that always move
web-watcher --once -m website --ignore 'ago|points' --baseline-file /tmp/hn.txt https://news.ycombinator.com/
```

## Uninstalling

```bash
brew untap maxgfr/tap
```
