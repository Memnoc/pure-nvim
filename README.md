<p align="center">
  <img src=".purenvim/assets/logo.png" alt="PureNvim" width="400">
</p>

<p align="center">
  <strong>Single-file, native-first, systems-focused.</strong>
</p>

<p align="center">
  <a href="#installation">Install</a> •
  <a href="#features">Features</a> •
  <a href="#keybindings">Keybindings</a> •
  <a href="#compile--run">Compile</a>
</p>

---

One file. Native APIs. **C**, **C++**, **Rust**.

- **Single `init.lua`** — no scattered modules, no complexity
- **Native Neovim 0.12+** — `vim.lsp`, `vim.treesitter`, `vim.pack`
- **5 plugins** — only what's necessary
- **Systems focus** — clangd, rust-analyzer, terminal debugging

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/memnoc/PureNvim/main/install.sh | bash
```

Or manually:

```bash
git clone https://github.com/memnoc/PureNvim ~/.config/PureNvim
alias pvim="NVIM_APPNAME=PureNvim nvim"
pvim
```

### Requirements

| Requirement | Install |
|-------------|---------|
| Neovim 0.12+ | [bob](https://github.com/MordechaiHadad/bob) (recommended) |
| ripgrep | `brew install ripgrep` / `pacman -S ripgrep` |
| fd | `brew install fd` / `pacman -S fd` |
| C compiler | Xcode CLI / `pacman -S gcc` |

### Post-Install

```vim
:Mason
```

Install: `clangd`, `rust-analyzer`, `lua-language-server`

Treesitter parsers auto-install on first launch.

## Features

| Feature | Implementation |
|---------|----------------|
| Syntax | Native `vim.treesitter` |
| LSP | Native `vim.lsp` |
| Completion | Native `vim.lsp.completion` |
| Fuzzy finder | mini.pick |
| File explorer | oil.nvim |
| Git signs | mini.diff |
| Text objects | mini.ai |
| Jumping | mini.jump2d |
| Statusline | Custom (no plugin) |
| Terminal | Custom floating/split |

### Plugins (5 total)

| Plugin | Purpose |
|--------|---------|
| [mini.nvim](https://github.com/echasnovski/mini.nvim) | pick, pairs, surround, comment, ai, diff, jump2d, starter |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | File explorer |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | Icons |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP installer |
| [clangd_extensions.nvim](https://github.com/p00f/clangd_extensions.nvim) | Enhanced C/C++ (AST, inlay hints) |

## Keybindings

Leader: `Space`

### Core

| Key | Action |
|-----|--------|
| `<C-s>` | Save |
| `<leader>q` | Quit |
| `<leader>e` | File explorer |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fr` | Recent files |
| `<leader>9` | Floating terminal |
| `s{char}` | Jump to character |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Definition |
| `gr` | References |
| `K` | Hover |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename |
| `<leader>lh` | Toggle inlay hints |
| `<leader>lt` | Toggle diagnostics |
| `[d` / `]d` | Prev/next diagnostic |

### Compile & Run

| Key | Action |
|-----|--------|
| `<leader>mc` | Compile & run C |
| `<leader>mr` | Cargo run |
| `<leader>mt` | Cargo test |
| `<leader>mb` | Cargo build |

<details>
<summary><strong>All keybindings</strong></summary>

### General

| Key | Action |
|-----|--------|
| `<C-s>` | Save file |
| `<leader>q` | Quit |
| `<leader>Q` | Force quit all |
| `<leader>so` | Save and source |
| `<Esc>` | Clear search highlight |

### Navigation

| Key | Action |
|-----|--------|
| `s{char}` | Jump to character (mini.jump2d) |
| `<C-h/j/k/l>` | Move between windows |
| `<C-d>` / `<C-u>` | Half page down/up (centered) |
| `n` / `N` | Next/prev search (centered) |

### Files

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fr` | Recent files |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |
| `<leader>fd` | Diagnostics |
| `<leader>e` | Oil float |
| `-` | Oil |

### Windows

| Key | Action |
|-----|--------|
| `<leader>/` | Split vertical |
| `<leader>-` | Split horizontal |
| `<leader>c` | Close split |
| `<C-h/j/k/l>` | Navigate |

### Buffers

| Key | Action |
|-----|--------|
| `<leader>bn` | Next |
| `<leader>bp` | Previous |
| `<leader>bd` | Delete |

### Tabs

| Key | Action |
|-----|--------|
| `<Tab>` | Next |
| `<S-Tab>` | Previous |
| `<leader>tn` | New |
| `<leader>tx` | Close |

### Terminal

| Key | Action |
|-----|--------|
| `<leader>9` | Float |
| `<C-/>` | Horizontal |
| `<Esc><Esc>` | Exit mode |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References |
| `gi` | Implementation |
| `K` | Hover documentation |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |
| `<leader>lf` | Format |
| `<leader>ld` | Show diagnostic float |
| `<leader>lh` | Toggle inlay hints |
| `<leader>lt` | Toggle diagnostics |
| `[d` / `]d` | Prev/next diagnostic |

### Compile & Run

| Key | Action |
|-----|--------|
| `<leader>mc` | Compile & run C file |
| `<leader>mr` | Cargo run |
| `<leader>mt` | Cargo test |
| `<leader>mb` | Cargo build |

</details>

## Compile & Run

### C

```vim
<leader>mc
```

Compiles with `gcc -Wall -Wextra -g` and runs immediately.

### Rust

```vim
<leader>mr   " cargo run
<leader>mt   " cargo test
<leader>mb   " cargo build
```

### Project Setup

For accurate clangd diagnostics, generate `compile_commands.json`:

```bash
# CMake
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .

# Make (requires bear)
bear -- make
```

## Philosophy

**Single file** — Everything in `init.lua`. Use `za` to fold sections.

**Native first** — Prefer `vim.lsp`, `vim.treesitter`, `vim.pack` over plugins.

**Systems focus** — Optimized for C, C++, Rust. Not general purpose.

**Debug from terminal** — No DAP overhead. Use `gdb`/`lldb` directly.

**Stable** — 5 plugins = less breakage.

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/memnoc/PureNvim/main/uninstall.sh | bash
```

## License

MIT
