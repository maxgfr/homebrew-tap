# Homebrew Tap

Personal Homebrew tap for [@maxgfr](https://github.com/maxgfr)'s projects.

## Installation

```bash
brew tap maxgfr/tap
```

## Available Formulae

### [andro](https://github.com/maxgfr/andro)

Run Android apps — phone or smart TV — from your macOS CLI, on a fast, disposable, self-contained Android emulator (Apple Silicon, native HVF). macOS only.

```bash
brew install maxgfr/tap/andro
andro run app.apk
```

### [package-checker](https://github.com/maxgfr/package-checker.sh)

A flexible, lightweight shell script to detect vulnerable npm packages.

```bash
brew install maxgfr/tap/package-checker
package-checker --help
```

### [binance-historical](https://github.com/maxgfr/binance-historical)

Download historical klines from Binance API with support for JSON and CSV export.

```bash
brew install maxgfr/tap/binance-historical
binance-historical download --help
```

### [git-recap](https://github.com/maxgfr/git-recap)

Monthly commit recap generator — AI-powered summaries, bullet points, and commit lists.

```bash
brew install maxgfr/tap/git-recap
git-recap --help
```

### [git-pilot](https://github.com/maxgfr/git-pilot)

AI-powered git automation: smart commits, conflict resolution, and auto-rebase.

```bash
brew install maxgfr/tap/git-pilot
git-pilot --help
```

### [copyable-pdf](https://github.com/maxgfr/copyable-pdf)

Make your PDF text copyable by adding an OCR layer (using Tesseract).

```bash
brew install maxgfr/tap/copyable-pdf
copyable-pdf --help
```

### [ratio-master](https://github.com/maxgfr/ratio-master)

A torrent ratio tool that sends real HTTP announce requests to BitTorrent trackers.

```bash
brew install maxgfr/tap/ratio-master
ratio-master --help
```

### [snatch](https://github.com/maxgfr/snatch)

Universal video downloader - yt-dlp + CDP browser fallback.

```bash
brew install maxgfr/tap/snatch
snatch --help
```

### [subtool](https://github.com/maxgfr/subtool)

All-in-one CLI for subtitle management: download, translate, convert, sync, clean, merge, fix, extract, and embed subtitles.

```bash
brew install maxgfr/tap/subtool
subtool --help
```

### [rshc](https://github.com/maxgfr/rshc)

Rust reimplementation of SHC — encrypts shell scripts into compiled binaries.

```bash
brew install maxgfr/tap/rshc
rshc --help
```

### [db-schema-toolkit](https://github.com/maxgfr/db-schema-viewer)

Parse, export, and analyze database schemas from the CLI. Supports SQL, Prisma, Drizzle, DBML, TypeORM, and more.

```bash
brew install maxgfr/tap/db-schema-toolkit
db-schema-toolkit help
```

### [web-watcher](https://github.com/maxgfr/web-watcher)

Watch APIs & websites for changes — get notified instantly from your terminal.
Depends on `webindex` (installed automatically), which website mode uses as its HTML-to-text extractor.

```bash
brew install maxgfr/tap/web-watcher
web-watcher --help
# Watch a page, ignoring the lines that always move
web-watcher --once -m website --ignore 'ago|points' --baseline-file /tmp/hn.txt https://news.ycombinator.com/
```

### [github-helpers](https://github.com/maxgfr/github-helpers)

GitHub maintenance toolkit: bulk unstar, org clone, and more.

```bash
brew install maxgfr/tap/github-helpers
github-helpers --help
```

### [claude-code-switch](https://github.com/maxgfr/claude-code-switch)

Minimal, zero-dependency provider switching for Claude Code — switch between Anthropic, OpenRouter, DeepSeek, Gemini, Mistral, OpenAI and custom endpoints.

```bash
brew install maxgfr/tap/claude-code-switch
ccs --help
```

### [llm-models](https://github.com/maxgfr/llm-models)

Fetch latest LLM models from OpenRouter and models.dev APIs — discover, compare, and estimate costs across providers.

```bash
brew install maxgfr/tap/llm-models
llm-models find -C reasoning --sort cost_input -n 10
```

### [conforme](https://github.com/maxgfr/conforme)

Sync your AI coding config from Claude Code, Cursor, or any tool — rules, skills, agents, MCP servers

```bash
brew install maxgfr/tap/conforme
conforme --help
```

### [claudfeine](https://github.com/maxgfr/claudfeine)

Run Claude Code caffeinated — keeps your machine awake for exactly the session, then restores normal sleep automatically. Transparent pass-through; zero dependencies.

```bash
brew install maxgfr/tap/claudfeine
claudfeine --continue
```

### [codexfeine](https://github.com/maxgfr/claudfeine)

Same as [claudfeine](https://github.com/maxgfr/claudfeine), but wraps OpenAI Codex — keeps your machine awake for exactly the session, then restores normal sleep automatically.

```bash
brew install maxgfr/tap/codexfeine
codexfeine
```

### [codexify](https://github.com/maxgfr/codexify)

A practical Codex CLI toolbelt — model profiles, Ghostty tab attention plus desktop notifications for completed turns and approvals, global config backup, keep-awake sessions, diagnostics, and project sync through Conforme.

```bash
brew install maxgfr/tap/codexify
codexify doctor
codexify notify on
```

### [codeindex](https://github.com/maxgfr/codeindex)

Zero-dependency repo-indexing engine: symbols, imports, typed cross-file link-graph, callers, SCIP export — CLI + MCP server included. Also on [npm](https://www.npmjs.com/package/@maxgfr/codeindex).

```bash
brew install maxgfr/tap/codeindex
codeindex index --repo . --out .codeindex
```

### [webindex](https://github.com/maxgfr/webindex)

The web-side companion to codeindex: turns a URL or a file into clean, citable text — HTML, PDFs through a six-rung ladder ending in OCR, and office documents — and serves that over MCP. Zero dependencies, no API key, every optional helper degrades to a note.

```bash
brew install maxgfr/tap/webindex
webindex fetch https://example.com
webindex extract report.pdf
webindex mcp                      # serve fetch/extract to an agent over stdio
webindex doctor                   # which rungs and helpers are available here
```

### [sift](https://github.com/maxgfr/sift)

Will this LLM fit and run fast on your machine? Answered before you download it — reads a model's real GGUF header off HuggingFace over range requests, measures your hardware, and says which quantization to get and which engine should run it. No bundled model list.

Note: `homebrew/core` ships an unrelated `sift` (a grep alternative), so install this one tap-qualified. The two cannot be linked at the same time.

```bash
brew install maxgfr/tap/sift
sift fit unsloth/Qwen3-30B-A3B-GGUF
```

### [scopelet](https://github.com/maxgfr/scopelet)

Compute before you send — replaces an oversized command output with a bounded view before the agent reads it, keeps the exact original bytes in a local store, and puts the recovery command on the first line. No second model call, no API key, no proxy.

Note: Homebrew installs the binary only. `scopelet install` copies it to `~/.config/scopelet/bin` and points the hooks at that copy, so re-run it after `brew upgrade scopelet`. The model-invocable skill is a separate install: `npx skills add maxgfr/scopelet --skill scopelet --global -a codex claude-code opencode -y`.

```bash
brew install maxgfr/tap/scopelet
scopelet install --agent all   # hooks for Claude Code, Codex and OpenCode
scopelet doctor                # binary, mode and hooks_configured per host
```

### [secretgate](https://github.com/maxgfr/secretgate)

Local secrets firewall for coding agents: detects credentials in prompts, file reads and tool output before they reach the model, redacts them to stable placeholders and restores the real values when the agent writes them back. Claude Code, Codex and OpenCode; 100% local, no Node needed.

Note: `secretgate init` copies the binary to `~/.secretgate/bin` and points the hooks at that copy, so re-run it after `brew upgrade secretgate`. The skill is a separate install: `npx skills add maxgfr/secretgate -g`.

```bash
brew install maxgfr/tap/secretgate
secretgate init                # detect the agents, wire their hooks, self-test them
secretgate scan .              # exit 1 on findings
```

### [swarmdeck](https://github.com/maxgfr/swarmdeck)

Drive a Swarmdeck torrent server from a terminal or an AI: add a magnet or a `.torrent`, pause, choose the files, wait, copy, link and remove its transfers; and inspect, edit, create and check `.torrent` files with no server at all. `swarmdeck-mcp` is the same as an MCP server.

Note: the server itself is not installed here. Run it with `npm run local` in a checkout of the repo, or as its Docker image, and point `SWARMDECK_URL` (default `http://127.0.0.1:8080`) and `SWARMDECK_TOKEN` at it.

```bash
brew install maxgfr/tap/swarmdeck
swarmdeck add 'magnet:?xt=urn:btih:…' && swarmdeck list
npx skills add maxgfr/swarmdeck                # the agent skill, for any agent
claude mcp add swarmdeck -- swarmdeck-mcp      # the MCP server (or: codex / opencode mcp add swarmdeck -- swarmdeck-mcp)
```

### [troupe](https://github.com/maxgfr/troupe)

Drive a self-hosted Troupe studio (short videos played by AI actors) from a terminal: sign in, add models, create projects, set scripts, chat, render, watch, export and download, and fill the inspiration library, with `--json` on every command. A standalone binary: no Node.js needed.

Note: the studio itself is not installed here. Run it with Docker (see the repo's quick start), then point the CLI at it with `troupe login --url`.

```bash
brew install maxgfr/tap/troupe
troupe login --url http://localhost:3100
troupe doctor && troupe open
```

### [veil](https://github.com/maxgfr/veil)

Send and receive files of any size, or chat, peer-to-peer and end-to-end encrypted, in the same rooms as the [Veil web app](https://maxgfr.github.io/veil/). No account and no server in the middle: rooms are a link, files are verified by SHA-256.

```bash
brew install maxgfr/tap/veil
veil send report.pdf                          # prints a room link and a QR code
veil receive 'https://maxgfr.github.io/veil/#…' --out ~/Downloads
```

### [pdfvault](https://github.com/maxgfr/pdfvault)

Private PDF and image tools from the terminal: compress (lossless, balanced, strong, extreme), merge, split, reorder, rotate, watermark, page numbers, AES-256 passwords, OCR to searchable PDF, PDF to Markdown, text or EPUB, and image compression, resizing, conversion and EXIF stripping. Everything runs on your machine, on the same Rust/WebAssembly engine as the [pdfvault web app](https://maxgfr.github.io/pdfvault/); `--json` on every command. A standalone binary with the OCR models built in: no Node.js or Bun needed.

```bash
brew install maxgfr/tap/pdfvault
pdfvault compress report.pdf --preset strong   # → report-compressed.pdf
pdfvault ocr scan.pdf && pdfvault to-md scan-searchable.pdf
npx skills add maxgfr/pdfvault                 # the agent skill, for any agent (Claude Code, Codex, OpenCode…)
```

### [verbatim](https://github.com/maxgfr/verbatim)

Transcribe and edit video and audio on your machine: NVIDIA Parakeet speech to text (25 languages, timed to the word) to TXT, SRT, VTT, Markdown, JSON or CSV, and cuts by time, by words said, hesitations or pauses, or in plain language ("supprime de 15:39 à 15:43 et les 5:42 dernières minutes"), rendered with ffmpeg. The same Rust engine as the [verbatim web app](https://maxgfr.github.io/verbatim/); `--json` and cut lists for scripts.

```bash
brew install maxgfr/tap/verbatim
verbatim transcribe talk.mp4 -o talk.srt
verbatim cut talk.mp4 "supprime de 15:39 à 15:43 et les 5:42 dernières minutes" -o short.mp4 --dry-run
npx skills add maxgfr/verbatim                 # the agent skill, for any agent (Claude Code, Codex, OpenCode…)
```

### [pixvault](https://github.com/maxgfr/pixvault)

Private photo tools from the terminal: compress (quality or target size), convert HEIC, RAW, AVIF, WebP, JPEG XL, TIFF and SVG, resize (social presets), crop, rotate, adjust, LUTs, watermarks, captions, redaction, EXIF/GPS stripping and editing, batch rename, collages, contact sheets, GIFs, PDFs, favicons, palettes and duplicate detection, plus AI tools (background removal, upscaling, face blurring, object eraser, captions and keywords). Everything runs on your machine, on the same engine as the [pixvault web app](https://maxgfr.github.io/pixvault/); folders are processed recursively and `--json` works on every tool. A standalone binary with the codecs built in; AI models download once, verified by SHA-256.

```bash
brew install maxgfr/tap/pixvault
pixvault compress --quality 75 --format webp photos/ -o small/
pixvault convert --to jpeg IMG_0042.HEIC
pixvault strip --remove gps *.jpg -o shared/
pixvault remove-bg product.jpg
```

### [aparte](https://github.com/maxgfr/aparte)

The command-line companion of [Aparté](https://maxgfr.github.io/aparte/), a private AI chat that runs entirely in the browser, encrypted at rest and synced end-to-end. The CLI reads and writes the same `aparte/1` format as the web app; `--json` prints one JSON object per line.

```bash
brew install maxgfr/tap/aparte
aparte selftest                               # offline check of the format and crypto
aparte doctor                                 # this machine and the directories in use
```

### [nuee](https://github.com/maxgfr/nuee)

Turn a trusted group's laptops and phones into a private, short-lived cloud from one link: verified compute, GPU tasks, encrypted file sharing, distributed training and hosting. Whoever opens the link, in a browser or with `nuee join` / `nuee get`, joins the swarm.

```bash
brew install maxgfr/tap/nuee
nuee share ./photos                           # prints a link, encrypted, until Ctrl-C
nuee get 'https://maxgfr.github.io/nuee/#…'
nuee selftest                                 # offline self-check
```

### [obscura](https://github.com/maxgfr/obscura)

The companion of [obscura](https://maxgfr.github.io/obscura/), a private recording studio that runs entirely in the browser. It decrypts recordings sealed with a passphrase (Argon2id + AES-256-GCM, the web app's format), checks whether a recording is whole, keeps an interrupted one up to its last complete fragment, and builds studio layout links. Everything runs offline. homebrew-core has an unrelated `obscura` (a headless browser), so install this one by its full name.

```bash
brew install maxgfr/tap/obscura
obscura decrypt obscura-20261021-143005.mp4.obscura   # asks for the passphrase (or OBSCURA_PASSPHRASE)
obscura inspect cut.mp4 && obscura repair cut.mp4     # after a crash or a closed tab
obscura selftest                                     # offline self-check
```

### [hush](https://github.com/maxgfr/hush)

Post-quantum, end-to-end encrypted chat and file transfer from the terminal, in the same conversations as the [hush web app](https://maxgfr.github.io/hush/). Send a link, talk, end it: nothing is left. X-Wing (X25519 + ML-KEM-768) handshake, a ratchet that rekeys with a fresh post-quantum exchange, 5 emojis to verify, files checked by SHA-256. It also reads the web app's encrypted backups. homebrew-cask has an unrelated `hush` app, so install this one by its full name.

```bash
brew install maxgfr/tap/hush
hush chat                                     # prints a link and a QR code, then chat (/ok to confirm the emojis)
hush send report.pdf                          # exits once the file is delivered
hush receive 'https://maxgfr.github.io/hush/#…' --out ~/Downloads
hush backup inspect hush-backup.hush
```

### [termrevive](https://github.com/maxgfr/termrevive)

Save your terminal sessions and get them back after a reboot: windows, tabs, splits, working directories and the programs running in them. Every coding agent resumes its own session — Claude Code, Codex, Mistral Vibe, opencode, Kilo, in the directory or worktree it was in — editors and `ssh` reopen, unknown commands are typed back without being run. Ghostty 1.3+, iTerm2, kitty and Terminal.app on macOS, in one snapshot; optional LaunchAgents save every 2 minutes and restore at login.

```bash
brew install maxgfr/tap/termrevive
termrevive save        # snapshot now
termrevive show        # what a restore would run
termrevive doctor --fix  # once: terminal settings restores need
termrevive restore     # after a reboot, from a fresh Ghostty window
termrevive install     # optional: auto-save + auto-restore at login
npx skills add maxgfr/termrevive   # agent skill for Claude Code, Codex…
```

## Uninstalling

```bash
brew untap maxgfr/tap
```
