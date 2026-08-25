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

A practical Codex CLI toolbelt — model profiles, reliable Action Required notifications, global config backup, keep-awake sessions, diagnostics, and project sync through Conforme.

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

## Uninstalling

```bash
brew untap maxgfr/tap
```
