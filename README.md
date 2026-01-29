# PureNvim

<p align="center">
  <img src="./assets/logo_2.png" alt="PureNvim" width="400">
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

- **Single `init.lua`** — but don't expect a 50 lines config
- **Native Neovim 0.12+** — `vim.lsp`, `vim.treesitter`, `vim.pack`, `snippets`, `autocompletion`
- **5 plugins** — can't promise will remain like that, but so far so good (also I' counting `mini` as one)
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

Aside from being on the nightly (use Bob BTW) and having something to fuzzy-find, you can change most of these:

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

## Plugins

This is really my only original thought (rare stuff): I wanted to select the survival kit of plug-ins,
and try to keep it at 3. Failed, so then changed to 5. You could get down to 4 if you don't care about
low-level languages, and to 3 if you don't care about icons, but then you cannot be my friend so...

| Plugin | Purpose |
|--------|---------|
| [mini.nvim](https://github.com/echasnovski/mini.nvim) | Core utilities (pick, pairs, surround, comment, ai, diff, jump2d, starter) |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | File explorer |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | Icons |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP/tool installer |
| [clangd_extensions.nvim](https://github.com/p00f/clangd_extensions.nvim) | Enhanced C/C++ support |

## Keybindings

This section helps me more than you, and no, we don't do [whichkey](https://github.com/folke/which-key.nvim) here,
(but thanks Folke for existing, we are not worthy).

Also, AI for sure missed something here (you really thought I'd compile this list by hand?!), so check the
`-- KEYMAPPINGS {{{` in `init.lua` for a an uo-to-date list. 

### General

| Key | Action |
|-----|--------|
| `<leader>` | Space |
| `<C-s>` | Save file |
| `<leader>q` | Quit |
| `<leader>Q` | Force quit all |
| `<Esc>` | Clear search highlight |

### Navigation

| Key | Action |
|-----|--------|
| `s{char}` | Jump to character (mini.jump2d) |
| `<C-h/j/k/l>` | Move between windows |
| `<C-d>` / `<C-u>` | Half page down/up (centered) |
| `n` / `N` | Next/prev search (centered) |

### File Explorer & Picker

| Key | Action |
|-----|--------|
| `<leader>e` | Float file explorer (Oil) |
| `-` | Open parent directory |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |
| `<leader>fr` | Recent files |
| `<leader>fd` | Diagnostics |

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

### Tabs

| Key | Action |
|-----|--------|
| `<Tab>` | Next tab |
| `<S-Tab>` | Previous tab |
| `<leader>tn` | New tab |
| `<leader>tx` | Close tab |

### Terminal

| Key | Action |
|-----|--------|
| `<leader>9` | Toggle floating terminal |
| `<C-/>` | Toggle horizontal terminal |

### Buffers & Splits

| Key | Action |
|-----|--------|
| `<leader>bd` | Delete buffer |
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |
| `<leader>sv` | Vertical split |
| `<leader>sh` | Horizontal split |
| `<leader>sx` | Close split |

## Features

This is where I (don't) change your mind about how cool this project is:

- **Native LSP** with clangd, rust-analyzer, and lua_ls
- **Convenient C/C++** with clangd_extensions (AST viewer, better inlay hints)
- **Convenient Rust** with full inlay hints (types, lifetimes, closures, etc.)
- **Git signs** in signcolumn via mini.diff
- **Text objects** via mini.ai
- **Sorry Leap and Flash** via mini.jump2d (single character mode)
- **Custom statusline** with mode indicator and git branch, so nothing new
- **Custom tabline** with tab numbers, yep
- **Floating & horizontal terminals** floating terminal is the best
- **Auto-install treesitter parsers** for the languages you add

## Philosophy

LMAO

- Single `init.lua` file
- Leverage native Neovim 0.12+ features (`vim.pack`, `vim.lsp.config`, `vim.lsp.enable`)
- Minimal external dependencies
- Systems programming focus (C, C++, Rust)
- Debug from the terminal (no DAP overhead)

## License

Do literally whatever you want with this.

[MIT](./LICENSE)
