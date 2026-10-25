# provider-org-exporter.koplugin

Adds **Org-mode** (`.org`) as an export target in KOReader's built-in
Exporter plugin.

## Requirements

* KOReader **2024.12** or newer (needs the `Provider` singleton introduced in
  [PR #12641](https://github.com/koreader/koreader/pull/12641)).

## Installation

Copy the entire `provider-org-exporter.koplugin` folder to your KOReader
plugins directory and restart the app:

| Platform | Path |
|---|---|
| Android | `/sdcard/koreader/plugins/` |
| Kobo | `/mnt/onboard/.adds/koreader/plugins/` |
| Kindle | `/mnt/us/koreader/plugins/` |
| PocketBook | `/mnt/ext1/applications/koreader/plugins/` |

After restarting, go to **Tools → Export highlights → Choose formats** and
enable **Org-mode**.

## Output format

For each exported book KOReader writes a file to `koreader/clipboard/`:

```
#+TITLE:   Thinking, Fast and Slow
#+AUTHOR:  Daniel Kahneman
#+DATE:    <2026-05-23 Sat>
#+STARTUP: overview
#+OPTIONS: toc:nil num:nil

* Thinking, Fast and Slow
:PROPERTIES:
:AUTHOR:   Daniel Kahneman
:EXPORTED: 2026-05-23 14:00
:END:

** Introduction

*** Page 12  <2026-04-10 14:32>
#+begin_quote
The premise of this book is that it is easier to recognize other
people's mistakes than our own.
#+end_quote

/Note:/ Great insight for self-reflection.

** Part 1: Two Systems

*** Page 45  <2026-04-11 09:15>
#+begin_quote
System 1 operates automatically and quickly, with little or no effort.
#+end_quote
```

## File structure

```
provider-org-exporter.koplugin/
├── _meta.lua        ← plugin metadata (name, description)
├── main.lua         ← entry point; registers target via Provider
└── orgexporter.lua  ← OrgExporter implementation (inherits BaseExporter)
```

## License

MIT