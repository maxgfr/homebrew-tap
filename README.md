# Homebrew Tap

Personal Homebrew tap for [@maxgfr](https://github.com/maxgfr)'s projects.

## Installation

```bash
brew tap maxgfr/tap
```

## Available Formulae

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

```bash
brew install maxgfr/tap/web-watcher
web-watcher --help
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

Universal AI coding agent config synchronization — treats AGENTS.md as source of truth, syncs to Claude Code, Cursor, Windsurf, Copilot.

```bash
brew install maxgfr/tap/conforme
conforme --help
```

## Uninstalling

```bash
brew untap maxgfr/tap
```
