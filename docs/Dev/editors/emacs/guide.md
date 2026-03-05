# Emacs Guide for Development

## Table of Contents

1. [Installation](#installation)
2. [Configuration Structure](#configuration-structure)
3. [Essential Keyboard Shortcuts](#essential-keyboard-shortcuts)
4. [Git Integration](#git-integration)
5. [Rust Development](#rust-development)
6. [Python Development](#python-development)
7. [C/C++ & LLVM Development](#cc--llvm-development)
8. [Web Development (TypeScript, JSON)](#web-development-typescript-json)
9. [PHP Development](#php-development)
10. [Bash Scripting](#bash-scripting)
11. [DevOps (Docker, Kubernetes, Ansible)](#devops-docker-kubernetes-ansible)
12. [Data Formats (YAML, XML, TOML)](#data-formats-yaml-xml-toml)
13. [Markdown Editing](#markdown-editing)
14. [Troubleshooting](#troubleshooting)

## Installation

### Step 1: Install Emacs

```bash
sudo apt update
sudo apt install emacs -y
```

Verify:

```bash
emacs --version
```

### Step 2: Run Setup Script

```bash
chmod +x setup-emacs.sh
./setup-emacs.sh
```

### Step 3: Install LSP Servers

```bash
# Rust
rustup component add rust-analyzer

# Python
npm install -g pyright

# TypeScript/JavaScript
npm install -g typescript-language-server typescript

# PHP
npm install -g intelephense

# Bash
npm install -g bash-language-server

# YAML
npm install -g yaml-language-server

# C/C++
sudo apt install clangd
```

### Step 4: First Launch

```bash
emacs
```

Wait 1-2 minutes for packages to download. If prompted about icons:

```emacs
M-x all-the-icons-install-fonts
```

## Configuration Structure

```bash
~/.emacs.d/
├── init.el              # Main entry point
├── custom.el            # Auto-generated custom variables
└── lisp/
    ├── common.el        # Theme, UI, completion, general settings
    ├── git.el           # Magit, git-gutter, git-timemachine
    ├── rust.el          # Rust mode, cargo commands
    ├── python.el        # Python mode, pyvenv
    ├── markdown.el      # Markdown mode
    ├── web.el           # TypeScript, JavaScript, JSON
    ├── php.el           # PHP mode
    ├── bash.el          # Shell scripting
    ├── devops.el        # Docker, Kubernetes, Ansible, Terraform
    ├── data-formats.el  # YAML, XML, TOML, CSV
    └── cpp.el           # C/C++, LLVM, Clang, CMake
    └── other.el         # Every other config file in future
```

### Important Files

| File | Purpose |
| --- | --- |
| `~/.emacs.d/init.el` | Main config (loads all modules) |
| `~/.emacs.d/lisp/*.el` | Modular config files |
| `~/.emacs` | **DO NOT USE** (overrides init.el) |

### Adding New Languages

1. Create `~/.emacs.d/lisp/newlang.el`
2. Add `(provide 'newlang)` at the end
3. Add `(require 'newlang)` to `init.el`

## Essential Keyboard Shortcuts

### Key Notation

| Symbol | Meaning | Example |
| --- | --- | --- |
| `C-` | Hold **Ctrl** | `C-x` = Ctrl+x |
| `M-` | Hold **Alt** (or press Esc) | `M-x` = Alt+x |
| `C-x C-s` | Ctrl+x, then Ctrl+s | Keep Ctrl held |
| `C-c r` | Ctrl+c, release, then r | |

### Survival Commands (Memorize First!)

| Keys | Action |
| --- | --- |
| `C-g` | **CANCEL anything** (panic button!) |
| `C-x C-s` | Save file |
| `C-x C-c` | Quit Emacs |
| `C-x C-f` | Open file |
| `C-/` | Undo |

### File Operations

| Keys | Action |
| --- | --- |
| `C-x C-f` | Open (find) file |
| `C-x C-s` | Save current file |
| `C-x C-w` | Save as |
| `C-x k` | Close (kill) buffer |
| `C-x C-c` | Quit Emacs |

### Navigation

| Keys | Action |
| --- | --- |
| `C-p` / `C-n` | Up / Down |
| `C-b` / `C-f` | Left / Right |
| `C-a` / `C-e` | Start / End of line |
| `M-<` / `M->` | Start / End of file |
| `M-g g` | Go to line number |
| `M-b` / `M-f` | Back / Forward word |
| `C-l` | Center screen on cursor |

### Search

| Keys | Action |
| --- | --- |
| `C-s` | Search forward |
| `C-r` | Search backward |
| `C-s C-s` | Repeat last search |
| `M-%` | Search and replace |
| `C-M-%` | Regex search and replace |

### Editing

| Keys | Action |
| --- | --- |
| `C-Space` | Start selection |
| `C-w` | Cut |
| `M-w` | Copy |
| `C-y` | Paste |
| `M-y` | Cycle paste history |
| `C-k` | Kill to end of line |
| `C-x h` | Select all |
| `M-d` | Delete word forward |
| `M-Backspace` | Delete word backward |

### Buffers

| Keys | Action |
| --- | --- |
| `C-x b` | Switch buffer |
| `C-x C-b` | List all buffers (ibuffer) |
| `C-x k` | Close buffer |
| `C-x Left/Right` | Previous/Next buffer |

### Windows (Splits)

| Keys | Action |
| --- | --- |
| `C-x 2` | Split horizontal |
| `C-x 3` | Split vertical |
| `C-x 1` | Close other windows |
| `C-x 0` | Close this window |
| `C-x o` | Switch to other window |
| `Shift+arrows` | Move between windows |

### Project Management

| Keys | Action |
| --- | --- |
| `C-c p p` | Switch project |
| `C-c p f` | Find file in project |
| `C-c p s g` | Grep in project |
| `C-c p k` | Kill project buffers |
| `C-c t` | Toggle treemacs (file tree) |

### LSP (Eglot)

| Keys | Action |
| --- | --- |
| `M-.` | Go to definition |
| `M-,` | Go back |
| `M-?` | Find references |
| `C-h .` | Show documentation |
| `M-x eglot-rename` | Rename symbol |
| `M-x eglot-format` | Format buffer |

### Help

| Keys | Action |
| --- | --- |
| `C-h k` | Help for key |
| `C-h f` | Help for function |
| `C-h v` | Help for variable |
| `C-h m` | Help for current mode |
| `M-x` | Run any command |

## Git Integration

### Magit (Main Git Interface)

Open with: `C-x g`

| Key | Action |
| --- | --- |
| `s` | Stage file/hunk |
| `u` | Unstage file/hunk |
| `c c` | Commit (then `C-c C-c` to confirm) |
| `P p` | Push |
| `F p` | Pull |
| `b b` | Switch branch |
| `b c` | Create branch |
| `l l` | View log |
| `d d` | Diff |
| `g` | Refresh |
| `q` | Quit |
| `Tab` | Expand/collapse |
| `?` | Show all commands |

### Git Gutter (Shows Changes in Gutter)

Automatic in all programming modes. Shows:

- `+` Added lines
- `-` Deleted lines
- `~` Modified lines

### Git Time Machine

| Keys | Action |
| --- | --- |
| `C-c g t` | Enter time machine |
| `p` / `n` | Previous / Next revision |
| `q` | Quit time machine |

### Blamer (Inline Blame)

| Keys | Action |
| --- | --- |
| `C-c g b` | Toggle blame mode |

### Forge (GitHub/GitLab)

After configuring authentication:

- View issues and PRs in Magit
- Create/review PRs from Emacs

## Rust Development

### Keybindings

| Keys | Action |
| --- | --- |
| `C-c r` | `cargo run` |
| `C-c b` | `cargo build` |
| `C-c c` | `cargo check` |
| `C-c t` | `cargo test` |
| `C-c l` | `cargo clippy` |

### LSP Features

| Keys | Action |
| --- | --- |
| `M-.` | Go to definition |
| `M-,` | Go back |
| `M-?` | Find references |

### Auto Features

- Format on save (rustfmt)
- Inline error checking
- Code completion after `::` or `.`
- TOML support for Cargo.toml

## Python Development

### Keybindings

| Keys | Action |
| --- | --- |
| `C-c r` | Run current file |
| `C-c t` | Run pytest |

### Virtual Environment

```emacs
M-x pyvenv-activate
```

Select your venv directory.

### LSP Setup

Install pyright:

```bash
npm install -g pyright
```

## C/C++ & LLVM Development

### Keybindings

| Keys | Action |
| --- | --- |
| `C-c b` | Build (cmake --build) |
| `C-c r` | Run executable |

### LSP Setup

Install clangd:

```bash
sudo apt install clangd
```

### Features

- Clang-tidy integration
- Modern C++ font lock
- CMake mode for CMakeLists.txt
- LLVM IR mode for `.ll` files
- TableGen mode for `.td` files

### For Clangd to Work

Create `compile_commands.json`:

```bash
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
```

Or use Bear:

```bash
bear -- make
```

## Web Development (TypeScript, JSON)

### Keybindings

Same as other modes:

| Keys | Action |
| --- | --- |
| `M-.` | Go to definition |
| `M-,` | Go back |

### Auto Features

- Prettier formatting on save
- 2-space indentation
- JSX/TSX support

### LSP Setup

```bash
npm install -g typescript-language-server typescript
```

## PHP Development

### Keybindings

| Keys | Action |
| --- | --- |
| `C-c r` | Run current file |
| `C-c l` | Lint (php -l) |

### LSP Setup

```bash
npm install -g intelephense
```

### Code Style

PSR-2 by default.

## Bash Scripting

### Keybindings

| Keys | Action |
| --- | --- |
| `C-c r` | Run script |
| `C-c c` | Check with shellcheck |

### LSP Setup

```bash
npm install -g bash-language-server
sudo apt install shellcheck
```

### Supported Files

- `.sh`, `.bash`, `.zsh`
- `bashrc`, `zshrc`

## DevOps (Docker, Kubernetes, Ansible)

### Docker

| Keys | Action |
| --- | --- |
| `C-c d` | Docker dashboard |

Features:

- Dockerfile syntax highlighting
- docker-compose.yml support

### Kubernetes

| Keys | Action |
| --- | --- |
| `C-c k` | Kubernetes overview |

### Ansible

- Auto-detected in YAML files with Ansible keywords
- `C-c ?` for ansible-doc

### Terraform

| Keys | Action |
| --- | --- |
| `M-.` | Go to definition |

Install LSP:

```bash
# Download from https://releases.hashicorp.com/terraform-ls/
```

## Data Formats (YAML, XML, TOML)

### YAML

- Auto LSP via yaml-language-server
- 2-space indentation

Install LSP:

```bash
npm install -g yaml-language-server
```

### XML

- Built-in nxml-mode
- Auto-close tags
- Schema validation

### TOML

- Syntax highlighting
- Used by Cargo.toml, pyproject.toml, etc.

### Other Formats

- CSV mode with column alignment
- Protobuf syntax highlighting

## Markdown Editing

### Formatting

| Keys | Action |
| --- | --- |
| `C-c C-s b` | **Bold** |
| `C-c C-s i` | *Italic* |
| `C-c C-s c` | `Code` |
| `C-c C-s q` | Blockquote |

### Links & Images

| Keys | Action |
| --- | --- |
| `C-c C-l` | Insert link |
| `C-c C-i` | Insert image |
| `C-c C-o` | Open link at cursor |

### Headings

| Keys | Action |
| --- | --- |
| `C-c C-s 1` | Insert H1 |
| `C-c C-s 2` | Insert H2 |
| `C-c C-s 3` | Insert H3 |

### Navigation

| Keys | Action |
| --- | --- |
| `C-c C-n` | Next heading |
| `C-c C-p` | Previous heading |
| `C-c C-u` | Up to parent heading |
| `Tab` | Fold/unfold section |
| `S-Tab` | Fold/unfold all |

### Lists & Checkboxes

| Keys | Action |
| --- | --- |
| `M-RET` | New list item |
| `C-c C-d` | Toggle checkbox |

### Preview

| Keys | Action |
| --- | --- |
| `C-c C-c l` | Preview in browser |
| `C-c C-c m` | Preview in buffer |

## Troubleshooting

### Config Not Loading on Startup

**Cause:** `~/.emacs` file exists

**Fix:**

```bash
mv ~/.emacs ~/.emacs.backup
```

### Eglot Says "Couldn't Guess LSP Server"

**Cause:** LSP server not installed or not in PATH

**Fix:** Install the appropriate LSP server (see Installation section)

### No Syntax Highlighting (Shows "Fundamental")

**Cause:** Mode not installed

**Fix:**

```emacs
M-x package-install RET <mode-name> RET
```

### Packages Not Installing

**Cause:** Package archives not refreshed

**Fix:**

```emacs
M-x package-refresh-contents
```

### Need to Reload Config

**Fix:** Open init.el and run:

```emacs
M-x eval-buffer
```

### LSP Not Starting

**Check:**

1. Is the server installed? (e.g., `which rust-analyzer`)
2. Is eglot running? (check status bar for `Eglot:`)
3. Restart: `M-x eglot-shutdown` then `M-x eglot`

### Icons Not Displaying

**Fix:**

```emacs
M-x all-the-icons-install-fonts
```

## Learning Path

| Week | Focus |
| --- | --- |
| 1 | Survival commands: `C-g`, save, open, quit |
| 2 | Navigation without mouse |
| 3 | Buffer and window management |
| 4 | Search and replace |
| 5 | Git with Magit |
| 6+ | One new shortcut per day |

**Pro tip:** Press `C-h k` then any key to learn what it does!

---

*Generated for Mehrdad's development journey*
*Emacs version: 29.3 | March 2025*
