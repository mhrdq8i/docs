# Emacs Cheat Sheet

## Key Notation

> `C-` = Ctrl <br/>
> `M-` = Alt (or Esc) <br/>
> `C-x C-s` = Ctrl+x Ctrl+s <br/>

## 🆘 SURVIVAL

| Keys | Action |
| --- | --- |
| `C-g` | **CANCEL ANYTHING** |
| `C-x C-s` | Save |
| `C-x C-f` | Open file |
| `C-x C-c` | Quit Emacs |
| `C-/` | Undo |

## 📁 Files & Buffers

| Keys | Action |
| --- | --- |
| `C-x C-f` | Open file |
| `C-x C-s` | Save |
| `C-x C-w` | Save as |
| `C-x b` | Switch buffer |
| `C-x k` | Close buffer |
| `C-x C-b` | List buffers |

## 🧭 Navigation

| Keys | Action |
| --- | --- |
| `C-p / C-n` | Up / Down |
| `C-b / C-f` | Left / Right |
| `C-a / C-e` | Line start / end |
| `M-< / M->` | File start / end |
| `M-g g` | Go to line |
| `M-b / M-f` | Word back / forward |

## ✂️ Editing

| Keys | Action |
| --- | --- |
| `C-Space` | Start selection |
| `C-w` | Cut |
| `M-w` | Copy |
| `C-y` | Paste |
| `C-k` | Kill to end of line |
| `C-x h` | Select all |
| `M-d` | Delete word |

## 🔍 Search

| Keys | Action |
| --- | --- |
| `C-s` | Search forward |
| `C-r` | Search backward |
| `M-%` | Search & replace |
| `C-M-%` | Regex replace |

## 🪟 Windows

| Keys | Action |
| --- | --- |
| `C-x 2` | Split horizontal |
| `C-x 3` | Split vertical |
| `C-x 1` | Close others |
| `C-x 0` | Close this |
| `C-x o` | Other window |
| `Shift+arrows` | Move between |

## 📂 Project

| Keys | Action |
| --- | --- |
| `C-c p p` | Switch project |
| `C-c p f` | Find file |
| `C-c p s g` | Grep project |
| `C-c t` | File tree |
| `C-c m` | Toggle minimap |

## 🔀 Git (Magit)

| Keys | Action |
| --- | --- |
| `C-x g` | Open Magit |
| `s / u` | Stage / Unstage |
| `c c` | Commit |
| `P p` | Push |
| `F p` | Pull |
| `b b` | Switch branch |
| `l l` | Log |
| `q` | Quit |

| Keys | Action |
| --- | --- |
| `C-c g t` | Time machine |
| `C-c g b` | Toggle blame |

## 🔧 LSP (All Languages)

| Keys | Action |
| --- | --- |
| `M-.` | Go to definition |
| `M-,` | Go back |
| `M-?` | Find references |
| `C-h .` | Documentation |

## 🦀 Rust

| Keys | Action |
| --- | --- |
| `C-c r` | cargo run |
| `C-c b` | cargo build |
| `C-c c` | cargo check |
| `C-c t` | cargo test |
| `C-c f` | cargo fmt |
| `C-c l` | cargo clippy |

## 🐍 Python

| Keys | Action |
| --- | --- |
| `C-c r` | Run file |
| `C-c d` | Debug file |

## 🐚 Bash

| Keys | Action |
| --- | --- |
| `C-c r` | Run script |
| `C-c c` | Shellcheck |

## 🐳 DevOps

| Keys | Action |
| --- | --- |
| `C-c a` | Ansible |
| `C-c d` | Docker |
| `C-c k` | Kubernetes |

## 📝 Markdown

| Keys | Action |
| --- | --- |
| `C-c C-s b` | **Bold** |
| `C-c C-s i` | *Italic* |
| `C-c C-s c` | `Code` |
| `C-c C-l` | Link |
| `C-c C-n/p` | Next/prev heading |
| `C-c C-d` | Toggle checkbox |
| `Tab` | Fold/unfold |
| `C-c C-c l` | Preview |

## ❓ Help

| Keys | Action |
| --- | --- |
| `C-h k` | Key help |
| `C-h f` | Function help |
| `C-h m` | Mode help |
| `M-x` | Run command |

## 🛠️ Troubleshooting

```bash
# Config not loading?
mv ~/.emacs ~/.emacs.backup

# Refresh packages
M-x package-refresh-contents

# Reload config
M-x eval-buffer

# Restart LSP
M-x eglot-shutdown
M-x eglot

# Install icons
M-x all-the-icons-install-fonts
M-x nerd-icons-install-fonts
```

## Quick Reference Box

```bash
╔═════════════════════════════════════════════════════════════╗
║  SURVIVAL    │  EDIT         │  WINDOWS     │  GIT          ║
║  C-g Cancel  │  C-w Cut      │  C-x 2 Horiz │  C-x g Magit  ║
║  C-x C-s Save│  M-w Copy     │  C-x 3 Vert  │  s Stage      ║
║  C-x C-f Open│  C-y Paste    │  C-x 1 Close │  c c Commit   ║
║  C-x C-c Quit│  C-/ Undo     │  C-x o Other │  P p Push     ║
╠═════════════════════════════════════════════════════════════╣
║  LSP         │  RUST         │  SEARCH      │  NAV          ║
║  M-. Def     │  C-c r Run    │  C-s Find    │  C-p Up       ║
║  M-, Back    │  C-c b Build  │  C-r Back    │  C-n Down     ║
║  M-? Refs    │  C-c t Test   │  M-% Replace │  M-g g Line   ║
║              │  C-c f Format │              │               ║
╚═════════════════════════════════════════════════════════════╝
```

---

See more cheat-sheet [***here***](https://quickref.me/emacs.html)
