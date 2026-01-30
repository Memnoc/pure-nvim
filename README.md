<div align="center">

<img src="./assets/pure_nvim_logo.png" alt="PureNvim" width="400">

# PureNvim

![Version](https://img.shields.io/badge/version-1.0.0-ff8596?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-6ef298?style=flat-square)
![Flavor](https://img.shields.io/badge/flavor-sweet-ffd85c?style=flat-square)

<br/>

<strong>Single-file, native-first, systems-focused.</strong>

<br/>

[Install](#installation) • [Features](#features) • [Keybindings](#keybindings) • [Compile](#compile--run)

</div>

---

## Philosophy
- **Single `init.lua`** — but don't expect a 50 lines config, more like 1k+
- **Native Neovim (including nightly APIs 0.12+)** — `vim.lsp`, `vim.treesitter`, `vim.pack`, `snippets`, `autocompletion`
- **very few external  plugins** — can't promise will remain like that, but so far so good (also I'm counting `mini` as one)
- **Systems focus** — sprinkled some niceties for C mainly, and tried to the same for Rust and C++ for good measure

## Intro
I was tired (not really) and had some (lot) of time on my hands to do this, and actually learned a bit about
Neovim, a fact I never failt to brag about using with my colleagues and friends.

This is your AI elevator pitch:

A minimal, native Neovim configuration for systems programming in C, C++, and Rust.
Built for Neovim 0.12+ with a focus on low-level development workflows.

It's kind of true though. I wanted to learn some Neovim API, and recently I had to re-write Treesitter 
in my config to adapt it to their `main` branch, and it upset me (old man yelling at treesitter clouds).

I asked my friend AI if it was down to help ending this dependencies madness, and it said **hold my beer** (for 20 bucks a month tho).
Proceeded to produce a copius amount of garbage code.
So I said **now you hold my beer** and went [here](https://neovim.io/doc/user/treesitter.html#treesitter) and studied a bunch, did not understand most of it, asked my friend AI for help, he said **say less** and low and behold:

I did what other hundreds of thousands (millions?!) people before me did: I wasted my (clearly not) precious time to write
my own Neovim config, quickly thought it would be a flex to call it a distro, and pretentiously uploaded it to git
with an unoriginal title and a complex of inferiority to vastly better set ups.

But, it sort of works for me, so there you go.

## Requirements

Aside from being on the nightly (use [Bob](https://github.com/MordechaiHadad/bob) BTW) and having something to fuzzy-find, you can change most of these:

- Neovim 0.12+ (nightly)
- Git
- C compiler (gcc/clang)
- [ripgrep](https://github.com/BurntSushi/ripgrep) for live grep
- [fd](https://github.com/sharkdp/fd) for file finding

### Recommended

- [bob](https://github.com/MordechaiHadad/bob) Neovim version manager
- Nerd Font for icons

## Installation

Thanks to however wrote the function to switch between neovim versions using the global variable, you rock!
If you need it, use this in your `bashrc` or `zshrc` and don't forget to `source` when you're done (like I always do).

```bash
# User configuration
alias nvim-kick="NVIM_APPNAME=PureNvim nvim"
alias nvim-lazyvim="NVIM_APPNAME=LazyVim nvim"

# Neovim distros control
function nvims() {
  items=("default" "PureNvim" "LazyVim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

bindkey -s "\C-a" "nvims"

```

### Installation steps

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone
git clone https://github.com/YOUR_USERNAME/PureNvim ~/.config/PureNvim

# Set NVIM_APPNAME (add to .zshrc or .bashrc)
export NVIM_APPNAME="PureNvim"

# Launch
nvim
# OR if you are using the function to switch Neovim configs
nvims
# Pick your config, and voila!
```

On first launch:
1. Plugins install automatically via `vim.pack`
2. You'll be prompted to install missing treesitter parsers
3. Open `:Mason` to install LSP servers

Remember: Treesitter -> parsers - Mason -> LSP servers

## Mason Setup

Open `:Mason` and install (more than this if you need other LSPs):

| Tool | Type | Languages |
|------|------|-----------|
| `clangd` | LSP | C, C++ |
| `rust-analyzer` | LSP | Rust |
| `lua-language-server` | LSP | Lua |

# Configuration & Architecture

PureNvim is designed to prioritize native Neovim features over external abstractions. This document details how the configuration leverages the core API and where external plugins are used strictly as enhancements.

## 1. Native Neovim Core Configuration

So, the idea here is to present how the core of this configuration with its features is built entirely using Neovim's built-in Lua API (`vim.api`, `vim.opt`, `vim.fn`, etc.). In theory (very), If you were to disable the `PLUGINS` block, all of the following would still work perfectly.

### Core Settings & Options

Basically, how the confguration behaves at its core, with a ton of sane settings taken from many good configurations, video tutorials and your favourite tech influencers.

| Feature | Configuration | Description |
| :--- | :--- | :--- |
| **Line Numbers** | `number`, `relativenumber` | Hybrid line numbers (relative + current line) for easier navigation. |
| **Indentation** | `tabstop=2`, `shiftwidth=2` | 2-space indentation, converting tabs to spaces (`expandtab`). |
| **Search** | `ignorecase`, `smartcase` | Case-insensitive search unless capital letters are used. Highlights matches (`hlsearch`). |
| **Scrolling** | `scrolloff=10` | Keeps 10 lines of context above/below cursor when scrolling. |
| **Undo System** | `undofile`, `undodir` | Persistent undo history saved to `~/.vim/undodir`, surviving editor restarts. |
| **Clipboard** | `clipboard="unnamedplus"` | Syncs Neovim's clipboard with the system clipboard (OS dependent). |
| **Split Behavior** | `splitright`, `splitbelow` | Splits open new windows to the right or bottom. |

### UI & Appearance (Native)

Visual elements customized without external UI libraries. Well, if you count the native colorscheme (Pastel Sorbet) I guess you do have some external configurations.

| Feature | Implementation | Description |
| :--- | :--- | :--- |
| **Statusline** | `_G.custom_statusline` | A fully custom Lua statusline showing mode, git branch, filename, filetype, and cursor position. Includes custom logic for search counts. |
| **Tabline** | `_G.custom_tabline` | A custom top tab bar showing open tabs and their active buffers, designed to be minimal. |
| **Cursor** | `guicursor` | Changes cursor shape based on mode (Block in Normal, Bar in Insert). |
| **Terminal** | `vim.api.nvim_open_win` | Custom floating terminal (`<leader>9`) and horizontal terminal (`<C-/>`) built using native floating windows and split commands. |

### Native LSP (Language Server Protocol)

This is where we have the features for the "IDE" side of the configuration.

| Feature | Implementation | Description |
| :--- | :--- | :--- |
| **LSP Config** | `vim.lsp.config` | Manually configures `clangd` (C/C++), `rust_analyzer` (Rust), and `lua_ls` (Lua) using the native client. |
| **Autocompletion** | `vim.lsp.completion` | Native omnifunc completion triggered manually (`<C-n>`) or by logic. Toggled via global var `g.lsp_autocompletion`. |
| **Formatting** | `vim.lsp.buf.format` | Built-in formatter. Toggled via `<leader>tf` (Format on Save). |
| **Diagnostics** | `vim.diagnostic` | Native diagnostic framework. Customized signs (●) and virtual text without external plugins. |
| **Inlay Hints** | `vim.lsp.inlay_hint` | Native inlay hints (types, parameter names) enabled for Rust and C++. |

### Native Features "Re-implementing" Plugins

Yep, this is where I re-invent the wheel big time. You don't need to do that, or do you? In this era of "just use a library", it feels refreshing implementing something, for once.

| Feature | "Replaces" Plugin | Implementation |
| :--- | :--- | :--- |
| **Snippets** | `LuaSnip` / `UltiSnips` | A pure Lua table-based snippet engine. It detects the filetype and expands text keywords (e.g., `main`, `for`) using `vim.snippet.expand`. |
| **Session Manager** | `auto-session` | Simple `mksession!` command mapped to `<leader>ss` to save/restore state to `~/.vim/session.vim`. |
| **Terminal Toggle** | `toggleterm.nvim` | The custom floating window function (`toggle_floating_terminal`) replicates this behavior entirely natively. |

---

## 2. External Plugins & Dependencies

This is really my only original thought (rare stuff): I wanted to select the survival kit of plug-ins,
and try to keep it as low as possible.

Anyway, these plugins are added via `vim.pack.add` using the native package manager. 
While they provide some "necessary" comfort, they are ncie haves, not foundations.

### Core Utilities
| Plugin | Usage | Dependency Level |
| :--- | :--- | :--- |
| **`mini.nvim`** | Used for **Pickers** (`mini.pick`), **File Explorer** icons, **Surround** actions, **Jump** motion (`mini.jump2d`), and **Diff** view. | **Medium**. It replaces several tools (Telescope, Flash, Surround). Removing it loses fuzzy finding and motion, but editing remains fully functional. |
| **`oil.nvim`** | A file explorer that lets you edit your filesystem like a buffer. Mapped to `<leader>e`. | **Low**. Can be replaced by native `netrw` (built-in file explorer). |
| **`nvim-web-devicons`** | Provides filetype icons for `oil.nvim` and `mini.pick`. | **Cosmetic**. If removed, icons just disappear; functionality is unaffected. |

### Visuals & Aesthetics
| Plugin | Usage | Dependency Level |
| :--- | :--- | :--- |
| **`pastel-sorbet.nvim`** | The colorscheme. Sets the visual theme. | **High (Visual)**. The config relies on its palette `c` for custom highlights. However, a "fallback" palette is hardcoded so the config **will not crash** if this is missing. |
| **`smear-cursor.nvim`** | Adds a trail effect to the cursor. | **None**. Purely cosmetic effect. |
| **`todo-comments.nvim`** | Highlights keywords like `TODO`, `FIXME` in comments. | **Low**. Useful for visibility, but not critical for editing. |

### LSP Enhancements
| Plugin | Usage | Dependency Level |
| :--- | :--- | :--- |
| **`mason.nvim`** | Helps install LSP servers (clangd, rust-analyzer) easily. | **Convenience**. You can install these servers manually on your system path. PureNvim uses it just to bootstrap tools. |
| **`clangd_extensions.nvim`** | Adds extra visual features to C++ LSP (inlay hints styling, AST view). | **Low**. Standard `clangd` works fine without it; this just makes it prettier. |

# Keymappings

The **Leader key** is mapped to `Space`.

## General & Core
| Key | Mode | Description |
| :--- | :---: | :--- |
| `<Esc>` | `n` | Clear search highlights |
| `<C-s>` | `n` | Save file |
| `<C-s>` | `i` | Save file and exit Insert mode |
| `<leader>so` | `n` | Save and source current file |
| `<leader>q` | `n` | Quit current window |
| `<leader>Q` | `n` | Force quit Neovim (`:qall!`) |
| `<leader>fc` | `n` | Edit `init.lua` config |
| `<leader>pa` | `n` | Copy current file path to clipboard |

## Window Management
| Key | Mode | Description |
| :--- | :---: | :--- |
| `<C-h>` | `n` | Focus left window |
| `<C-j>` | `n` | Focus lower window |
| `<C-k>` | `n` | Focus upper window |
| `<C-l>` | `n` | Focus right window |
| `<leader>/` | `n` | Split window vertically |
| `<leader>-` | `n` | Split window horizontally |
| `<C-Up>` | `n` | Increase window height |
| `<C-Down>` | `n` | Decrease window height |
| `<C-Left>` | `n` | Decrease window width |
| `<C-Right>` | `n` | Increase window width |

## Editing & Navigation
| Key | Mode | Description |
| :--- | :---: | :--- |
| `J` | `n` | Join lines (keeps cursor position) |
| `<A-j>` | `n` | Move current line down |
| `<A-k>` | `n` | Move current line up |
| `J` | `v` | Move selection down |
| `K` | `v` | Move selection up |
| `<A-j>` | `v` | Move selection down (Alternate) |
| `<A-k>` | `v` | Move selection up (Alternate) |
| `<` | `v` | Indent left (stays in visual mode) |
| `>` | `v` | Indent right (stays in visual mode) |
| `p` | `v` | Paste without overwriting register (void yank) |
| `<C-d>` | `n` | Scroll half page down (centered) |
| `<C-u>` | `n` | Scroll half page up (centered) |
| `n` | `n` | Next search result (centered) |
| `N` | `n` | Previous search result (centered) |
| `<leader>c` | `n/v` | Toggle comment |
| `<leader>sa` | `n` | Select all text |
| `<leader>sp` | `n` | Toggle spell check |

## Buffers & Tabs
| Key | Mode | Description |
| :--- | :---: | :--- |
| `<leader>bn` | `n` | Next buffer |
| `<leader>bp` | `n` | Previous buffer |
| `<leader>bd` | `n` | Delete current buffer |
| `<Tab>` | `n` | Next tab |
| `<S-Tab>` | `n` | Previous tab |
| `<leader>tn` | `n` | New tab |
| `<leader>tx` | `n` | Close current tab |

## Search & Pickers (Mini.pick)
| Key | Mode | Description |
| :--- | :---: | :--- |
| `<leader>ff` | `n` | Find files |
| `<leader>fg` | `n` | Live Grep (text search) |
| `<leader>fb` | `n` | Find open buffers |
| `<leader>fh` | `n` | Help tags |
| `<leader>fr` | `n` | Recent files |
| `<leader>fd` | `n` | Workspace diagnostics |
| `<C-j>` | `pick` | Move selection down |
| `<C-k>` | `pick` | Move selection up |

## LSP & Diagnostics
| Key | Mode | Description |
| :--- | :---: | :--- |
| `gd` | `n` | Go to Definition |
| `gD` | `n` | Go to Declaration |
| `<leader>rn` | `n` | Rename symbol |
| `<leader>ca` | `n` | Code Actions |
| `<leader>lf` | `n` | Format buffer |
| `[d` | `n` | Go to previous diagnostic |
| `]d` | `n` | Go to next diagnostic |
| `<leader>ld` | `n` | Open line diagnostic (float) |
| `<leader>lt` | `n` | Toggle diagnostics globally |
| `<leader>lh` | `n` | Toggle inlay hints |
| `<leader>ta` | `n` | Toggle **Autocompletion** |
| `<leader>tf` | `n` | Toggle **Format on Save** |

## File Explorer (Oil)
| Key | Mode | Description |
| :--- | :---: | :--- |
| `<leader>e` | `n` | Open file explorer (floating) |
| `-` | `n` | Open parent directory (buffer) |

## Terminal
| Key | Mode | Description |
| :--- | :---: | :--- |
| `<leader>9` | `n` | Toggle floating terminal |
| `<C-/>` | `n` | Toggle horizontal terminal |
| `<Esc><Esc>` | `t` | Exit terminal mode to Normal mode |

## Snippets & Completion
| Key | Mode | Description |
| :--- | :---: | :--- |
| `<Tab>` | `i` | Expand snippet OR Accept completion |
| `<C-n>` | `i` | Manually trigger completion menu |
| `<leader>ls` | `n` | List available snippets for filetype |
| `<C-r><C-d>` | `i` | Insert current Date (YYYY-MM-DD) |
| `<C-r><C-t>` | `i` | Insert current Time (HH:MM:SS) |

## Compilation (C/Rust)
| Key | Mode | Description |
| :--- | :---: | :--- |
| `<leader>mc` | `n` | Compile & Run C file (gcc) |
| `<leader>mr` | `n` | Cargo Run |
| `<leader>mt` | `n` | Cargo Test |
| `<leader>mb` | `n` | Cargo Build |

## Motion & Utility
| Key | Mode | Description |
| :--- | :---: | :--- |
| `s` | `n/x` | **Jump 2d** (Mini.jump2d) - Jump to char |
| `]t` | `n` | Next TODO comment |
| `[t` | `n` | Previous TODO comment |
| `<leader>ss` | `n` | Save Session |
| `<leader>sr` | `n` | Restore Session |

## License

[MIT](./LICENSE)
