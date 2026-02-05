-- INTRO {{{
-- You are reading the main (and only) config file of PureNvim.
-- PureNvim philosophy is giving the end user full control of the config with little to
-- no abstractions. This is why the Core systems it's almost entirely native Neovim API.
-- You may need to use a nightly version of Neovim. PureNvim was developed under Neovim 0.12.0.
-- To navigate the (long) configuration, make use of the -- SECTION MARKERS {{{}}}:
-- / to search
-- Space-zM to fold all section markers
-- Space to open one section marker
-- Space-zR to unfold all section markers
-- }}}

-- GLOBALS {{{
-- INFO: Globals
-- This is where your global values are grouped for efficiency and control.
-- Generally, do not touch these, unless you want to add something.
local o = vim.opt
local g = vim.g
local api = vim.api
local map = vim.keymap.set
-- DOCS: AUGROUPS
-- https://learnvimscriptthehardway.stevelosh.com/chapters/14.html
-- TL:DR augroup make it easy to clear many autocmd's at once and also provide away to re-:source without duplicating autocmd's
local augroup = api.nvim_create_augroup("UserConfig", {})
-- }}}

-- PLUGINS {{{
-- INFO: plugins
-- Add your plugins here.
-- To add a language: https://github.com/Memnoc/pure-nvim/blob/main/recipes/add_language.md
vim.pack.add({
  -- Core
  { src = "https://github.com/echasnovski/mini.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },

  -- LSP
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/p00f/clangd_extensions.nvim" },

  -- Effects
  { src = "https://github.com/sphamba/smear-cursor.nvim" },
  { src = "https://github.com/folke/todo-comments.nvim" },

  -- Colorscheme
  { src = "https://github.com/Memnoc/pastel-sorbet.nvim" },
})
-- }}}

-- PASTEL-SORBET {{{
-- INFO: Colorscheme
-- The colorscheme of PureNvim!
-- By default, as a plugin: https://github.com/Memnoc/pastel-sorbet.nvim/blob/main/README.md
-- Refer to the /recipes/pastel-sorbet.lua if you want to see how the whole
-- colorscheme can be included in the configuration.
-- WARN: It's necessary to set up colors this way because vim.pack.add is asynchronous. This workaround works on first launch (fallback), then uses the real module once downloaded.
vim.cmd.colorscheme("pastel_sorbet")
local ok, c = pcall(require, "pastel_sorbet.palette")
if not ok then
  c = {
    bg = "#1c1826",
    bg_dark = "#14111c",
    bg_ui = "#2e2840",
    fg = "#e8e4f2",
    fg_dim = "#cdc8da",
    grey = "#726a88",
    grey_light = "#9c94b2",
    linenr = "#4e4662",
    red = "#ff8596",
    red_bright = "#ffa0b0",
    green = "#6ef298",
    green_bright = "#52edb8",
    yellow = "#ffd85c",
    yellow_bright = "#ffe48a",
    blue = "#7db8ff",
    blue_bright = "#a8d0ff",
    purple = "#c88df7",
    purple_bright = "#dba8ff",
    cyan = "#4cf0d8",
    cyan_bright = "#7af5e4",
    pink = "#ff8ed0",
    lime = "#b8f55c",
    teal = "#3df2c4",
    amber = "#ffa85c",
  }
end



-- OPTIONS {{{
-- INFO: Options
-- Some sane defaults.
-- Took heavy inspirations from various configs over the years
-- Line numbers {{{
o.number = true
o.relativenumber = true
o.cursorline = true
-- }}}

-- Indentation {{{
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.smartindent = true
o.autoindent = true
-- }}}

-- Wrapping and scroll {{{
-- o.wrap = true
o.scrolloff = 10
o.sidescrolloff = 8
-- }}}

-- Search {{{
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true
-- }}}

-- Appearance {{{
o.termguicolors = true
o.signcolumn = "yes:2"
o.colorcolumn = "100"
o.showmatch = true
o.matchtime = 3
o.cmdheight = 1
o.showmode = false
o.pumheight = 10
o.pumblend = 10
o.winblend = 0
o.conceallevel = 0
o.concealcursor = ""
o.synmaxcol = 300
o.winborder = "rounded"
o.laststatus = 3
-- Set thick character set for borders
vim.opt.fillchars = {
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft = '┫',
  vertright = '┣',
  verthoriz = '╋',
}
api.nvim_set_hl(0, "WinSeparator", {
  fg = c.purple_bright,
})
-- }}}

-- Completion {{{
o.completeopt = "menuone,noselect,popup"
o.wildmenu = true
o.wildmode = "longest:full,full"
o.wildignore:append({ "*.o", "*.obj", "*.a", "*.so", "*.d", "*.pyc", "*.class", "*.jar", "target/*" })
o.diffopt:append("linematch:60")
-- }}}

-- Performance {{{
o.updatetime = 300
o.timeoutlen = 500
o.ttimeoutlen = 0
o.maxmempattern = 20000
o.redrawtime = 3000
-- }}}

-- Files {{{
o.backup = false
o.writebackup = false
o.swapfile = false
o.undofile = true
o.undodir = vim.fn.expand("~/.vim/undodir")
o.autoread = true
o.autowrite = false
o.encoding = "UTF-8"
-- }}}

-- Behaviour {{{
o.hidden = true
o.errorbells = false
o.backspace = "indent,eol,start"
o.autochdir = false
o.iskeyword:append("-")
o.path:append("**")
o.selection = "exclusive"
o.mouse = "a"
o.clipboard = "unnamedplus"
o.modifiable = true
-- }}}

-- Folding {{{
o.foldmethod = "marker"
o.foldlevelstart = 99
-- }}}

-- Cursor {{{
o.guicursor = table.concat({
  "n-v-c:block",
  "i-ci-ve:block",
  "r-cr:hor20",
  "o:hor50",
}, ",")
-- }}}

-- Completion {{{
o.completeopt = "menuone,noselect,popup"
o.pumblend = 0
o.wildmenu = true
-- }}}

-- Spell {{{
o.spelllang = "en_us"
-- }}}

-- Search count occurrences
-- Enables native [1/10] search count message
-- Redundant if you use the custom statusline
-- o.shortmess:remove("S")
-- }}}

-- }}}

-- HIGHLIGHTS {{{
-- INFO: Highlights
-- If you are not using Pastel Sorbet as a plugin, this section shows you how to override values to set custom colors for things like menus, statusline, pop ups, etc.
-- Example:
-- vim.cmd.colorscheme("pastel_sorbet")
-- Override specific highlights if needed
-- vim.api.nvim_set_hl(0, "SomeGroup", { fg = "#ffffff" })
-- For a full manual config, look into recipes/pastel-sorbet.md
--
-- }}}

-- KEYMAPPINGS {{{
-- INFO: Keymappings
-- Most of the keymappings leave here. Some leave uner the plugins configurations,
-- and all (big lie) are listed here: https://github.com/Memnoc/pure-nvim/blob/main/README.md
g.mapleader = " "

-- General {{{
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<C-s>", "<cmd>write<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>write<CR>", { desc = "Save file and exit insert" })
map("n", "<leader>b", function()
  vim.cmd("write | source%")
  print("File sourced")
end, { desc = "Save and source" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qall!<CR>", { desc = "Force quit all" })
map("n", "<leader>;", function()
  require("mini.starter").open()
end, { desc = "Dashboard" })
-- }}}

-- Windows {{{
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<leader>wd", "<cmd>close<CR>", { desc = "Delete window" })
map("n", "<leader>/", "<cmd>vsplit<CR>", { desc = "Split vertical" })
map("n", "<leader>-", "<cmd>split<CR>", { desc = "Split horizontal" })
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase width" })
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
-- }}}

-- Buffers {{{
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "Open new buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<S-l>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
-- }}}

-- Toggles {{{
map("n", "<leader>uw", function()
  vim.opt.wrap = not vim.opt.wrap
  print("Wrap: " .. (vim.opt.wrap and "ON" or "OFF"))
end, { desc = "Toggle wrap" })
map("n", "<leader>uL", "<cmd>set relativenumber!<CR>", { desc = "Toggle relative numbers" })
map("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle wrap" })
map("n", "<leader>uL", "<cmd>set relativenumber!<CR>", { desc = "Toggle relative number" })
-- }}}

-- Treesitter {{{
map("n", "<leader>ui", function() vim.show_pos() end, { desc = "Inspect position" })
map("n", "<leader>uI", "<cmd>InspectTree<CR>", { desc = "Inspect treesitter tree" })
-- }}}

-- Move lines {{{
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
-- }}}

-- Better navigation {{{
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search (centered)" })

-- Quickfix/Location
map("n", "[q", "<cmd>cprevious<CR>", { desc = "Prev quickfix" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })
map("n", "<leader>xq", "<cmd>copen<CR>", { desc = "Quickfix list" })
map("n", "<leader>xl", "<cmd>lopen<CR>", { desc = "Location list" })
-- }}}

-- Visual mode {{{
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })
map("v", "p", '"_dP', { desc = "Paste without yank" })
-- }}}

-- Comments {{{
-- I am a heavy user of gcc so I disable this in my personal workflow
-- map("n", "<leader>c", "gcc", { remap = true, desc = "Toggle comment" })
-- map("v", "<leader>c", "gc", { remap = true, desc = "Toggle comment" })
-- }}}

-- Files {{{
map("n", "<leader>fc", "<cmd>e ~/.config/PureNvim/init.lua<CR>", { desc = "Edit config" })
map("n", "<leader>pa", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("file:", path)
end, { desc = "Copy file path" })
-- }}}

-- Session {{{
map("n", "<leader>ss", "<cmd>mksession! ~/.vim/session.vim<CR>", { desc = "Save session" })
map("n", "<leader>sr", "<cmd>source ~/.vim/session.vim<CR>", { desc = "Restore session" })
-- }}}

-- Misc {{{
map("n", "<leader>sp", "<cmd>set spell!<CR>", { desc = "Toggle spell check" })
map("n", "<leader>sa", "ggVG", { desc = "Select all" })
map("i", "<C-r><C-d>", '<C-r>=strftime("%Y-%m-%d")<CR>', { desc = "Insert date" })
map("i", "<C-r><C-t>", '<C-r>=strftime("%H:%M:%S")<CR>', { desc = "Insert time" })
-- }}}

-- Quick compile shortcuts for C/Rust {{{
map("n", "<leader>mc", "<cmd>!gcc -Wall -Wextra -g % -o %:r && ./%:r<CR>", { desc = "Compile & run C" })
map("n", "<leader>mr", "<cmd>!cargo run<CR>", { desc = "Cargo run" })
map("n", "<leader>mt", "<cmd>!cargo test<CR>", { desc = "Cargo test" })
map("n", "<leader>mb", "<cmd>!cargo build<CR>", { desc = "Cargo build" })
-- }}}

-- Manual completion trigger {{{
map("i", "<C-n>", function()
  vim.lsp.completion.get()
end, { desc = "Trigger completion" })
-- }}}

-- Tab to accept completion {{{
-- DOCS: PUMVISIBLE
--  Returns non-zero when the popup menu is visible, zero otherwise.
--  See |ins-completion-menu|.
--  This can be used to avoid some things that would remove the popup menu.
map("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-y>"
  else
    return "<Tab>"
  end
end, { expr = true })
-- }}}

-- }}}

-- AUTOCMDS {{{
-- INFO: Autocommands
-- These are the ones I use most, but you can disagree and remove/add as you please
-- and most likely not break anything.

-- Return to last position {{{
api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = api.nvim_buf_get_mark(0, '"')
    local lcount = api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
-- }}}

-- Highlight yanked text {{{
api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- }}}

-- Create undo directory {{{
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
-- }}}

-- Auto-close terminal {{{
api.nvim_create_autocmd("TermClose", {
  group = augroup,
  callback = function()
    if vim.v.event.status == 0 then
      api.nvim_buf_delete(0, {})
    end
  end,
})
-- }}}

-- Auto-resize splits {{{
api.nvim_create_autocmd("VimResized", {
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
-- }}}

-- Auto-create directories {{{
api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})
-- }}}

-- }}}

-- TERMINAL {{{
-- INFO: Terminal
-- I am a big proponent of a central-framed floating terminal, and from the ToggleTerm days,
-- I map that to <leader>9. You can remap it, of course, and not use the Neovim native terminal.
-- The customization and aesthetic of the terminal are mostly here.
-- I also use a horizontal terminal, triggered with C-/, also native.
local float_term = { buf = nil, win = nil }
local horiz_term = { buf = nil, win = nil }

-- Floating terminal {{{
local function toggle_floating_terminal()
  if float_term.win and api.nvim_win_is_valid(float_term.win) then
    api.nvim_win_hide(float_term.win)
    return
  end

  if not float_term.buf or not api.nvim_buf_is_valid(float_term.buf) then
    float_term.buf = api.nvim_create_buf(false, true)
    api.nvim_set_option_value("bufhidden", "hide", { buf = float_term.buf })
  end

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  float_term.win = api.nvim_open_win(float_term.buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
    border = "rounded",
  })

  api.nvim_set_option_value("winhl", "Normal:Normal,FloatBorder:FloatBorder", { win = float_term.win })

  if vim.bo[float_term.buf].buftype ~= "terminal" then
    vim.cmd.terminal()
  end
  vim.cmd.startinsert()
end

map("n", "<leader>9", toggle_floating_terminal, { desc = "Toggle floating terminal" })
-- }}}

-- Horizontal terminal {{{
local function toggle_horizontal_terminal()
  if horiz_term.win and api.nvim_win_is_valid(horiz_term.win) then
    api.nvim_win_hide(horiz_term.win)
    return
  end

  if not horiz_term.buf or not api.nvim_buf_is_valid(horiz_term.buf) then
    horiz_term.buf = api.nvim_create_buf(false, true)
    api.nvim_set_option_value("bufhidden", "hide", { buf = horiz_term.buf })
  end

  vim.cmd("botright 15split")
  horiz_term.win = api.nvim_get_current_win()
  api.nvim_win_set_buf(horiz_term.win, horiz_term.buf)

  if vim.bo[horiz_term.buf].buftype ~= "terminal" then
    vim.cmd.terminal()
  end
  vim.cmd.startinsert()
end

map("n", "<C-/>", toggle_horizontal_terminal, { desc = "Toggle horizontal terminal" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- }}}

-- }}}

-- TABS {{{
-- INFO: Tabs
-- Tabs are custom-implemented in PureNvim.
-- The idea is to have clear indicators, but using very minimal real-estate
-- Tabline {{{
function _G.custom_tabline()
  local s = ""
  for i = 1, vim.fn.tabpagenr("$") do
    local winnr = vim.fn.tabpagewinnr(i)
    local bufnr = vim.fn.tabpagebuflist(i)[winnr]
    local bufname = vim.fn.bufname(bufnr)
    local filename = bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or "[No Name]"

    if i == vim.fn.tabpagenr() then
      s = s .. "%#TabLineSel#"
    else
      s = s .. "%#TabLine#"
    end

    s = s .. " " .. i .. ":" .. filename .. " "
  end

  s = s .. "%#TabLineFill#"
  return s
end

o.tabline = "%!v:lua.custom_tabline()"
o.showtabline = 2
-- }}}

-- Navigation {{{
map("n", "<Tab>", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<S-Tab>", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
map("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "Close other tabs" })
-- }}}

-- }}}

-- STATUSLINE {{{
-- INO: Statusline
-- A custom-made very simple status line with mods, git, file(name, type)
-- and some bear navigation indicators
-- Mode tables {{{
local mode_hl = {
  n = "StatusLineMode",
  i = "StatusLineModeInsert",
  v = "StatusLineModeVisual",
  V = "StatusLineModeVisual",
  ["\22"] = "StatusLineModeVisual",
  c = "StatusLineModeCommand",
  R = "StatusLineModeReplace",
  r = "StatusLineModeReplace",
  t = "StatusLineModeInsert",
}

local mode_names = {
  n = " NORMAL ",
  i = " INSERT ",
  v = " VISUAL ",
  V = " V-LINE ",
  ["\22"] = " V-BLOCK ",
  c = " COMMAND ",
  R = " REPLACE ",
  r = " REPLACE ",
  t = " TERMINAL ",
}
-- }}}

-- Git branch {{{
local git_cache = { branch = "" }

local function update_git_branch()
  vim.fn.jobstart("git branch --show-current 2>/dev/null", {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data and data[1] and data[1] ~= "" then
        git_cache.branch = " " .. data[1] .. " "
      else
        git_cache.branch = ""
      end
      vim.schedule(function()
        pcall(vim.cmd.redrawstatus)
      end)
    end,
  })
end

local function git_branch()
  return git_cache.branch
end

api.nvim_create_autocmd({ "BufEnter", "FocusGained", "DirChanged" }, {
  group = augroup,
  callback = update_git_branch,
})
-- }}}

-- STATUSLINE {{{
-- INFO: Statusline
-- A custom-made very simple status line with mods, git, file(name, type)
-- and some bear navigation indicators

-- Search count function {{{
local function count_search()
  if vim.v.hlsearch == 1 then
    local res = vim.fn.searchcount({ maxcount = 999, timeout = 500 })
    if res.total > 0 then
      return "%#StatusLineMode# [" .. res.current .. "/" .. res.total .. "] %*"
    end
  end
  return ""
end
-- }}}

-- Statusline settings {{{
function _G.custom_statusline()
  local mode = api.nvim_get_mode().mode
  local mode_highlight = mode_hl[mode] or "StatusLineMode"
  local name = mode_names[mode] or (" " .. mode .. " ")

  local parts = {
    "%#" .. mode_highlight .. "#" .. name,
    "%#StatusLineSep#│",
    "%#StatusLineGit#" .. git_branch(),
    "%#StatusLineSep#│",
    "%#StatusLineFile# %f %m%r",
    count_search(), -- Calling the custom function here
    "%=",
    "%#StatusLineFileType# %Y ",
    "%#StatusLineSep#│",
    "%#StatusLinePos# %l:%c │ %p%% ",
  }

  return table.concat(parts)
end

o.statusline = "%!v:lua.custom_statusline()"
-- }}}

-- }}}

-- TREESITTER {{{
-- INFO: Treesitter implementation
-- REQUIRES: tree-sitter CLI for parser compilation
--   brew install tree-sitter  (macOS)
--   cargo install tree-sitter-cli  (cross-platform)
-- Docs: https://github.com/nvim-treesitter/nvim-treesitter

-- Parsers to install {{{
-- INFO: parsers implementation
-- Edit this list to add/remove languages for your workflow.
-- On first launch, missing parsers install automatically in the background.
-- Manual commands:
--   :TSInstall <lang>    - Install a parser
--   :TSUninstall <lang>  - Remove a parser
--   :TSUpdate            - Update all parsers
--   :TSLog               - Show install log (useful for debugging)
local treesitter_parsers = {
  "c",
  "lua",
  "rust",
  "cpp",
  "toml",
  "json",
  "yaml",
  "markdown",
  "markdown_inline",
}
-- }}}

-- Auto-enable highlighting {{{
api.nvim_create_autocmd("FileType", {
  group = augroup,
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
-- }}}

-- Auto-install missing parsers {{{
api.nvim_create_autocmd("VimEnter", {
  group = augroup,
  once = true,
  callback = function()
    vim.defer_fn(function()
      if vim.fn.executable("tree-sitter") ~= 1 then
        vim.notify(
          "Treesitter: 'tree-sitter' CLI not found. Install it to enable parser compilation:\n"
          .. "  brew install tree-sitter  (macOS)\n"
          .. "  cargo install tree-sitter-cli  (cross-platform)",
          vim.log.levels.WARN
        )
        return
      end

      local ok_ts, ts = pcall(require, "nvim-treesitter")
      if not ok_ts then
        return
      end

      local installed = ts.get_installed()
      local missing = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, treesitter_parsers)

      if #missing == 0 then
        return
      end

      vim.notify(
        "Treesitter: installing parsers (" .. table.concat(missing, ", ") .. ")",
        vim.log.levels.INFO
      )
      for _, lang in ipairs(missing) do
        ts.install(lang)
      end
    end, 200)
  end,
})
-- }}}

-- }}}

-- PLUGIN CONFIG {{{
-- INFO: Plugin Configuration
-- After you declare your plugins in the PLUGINS section,
-- you come here to configure them.
-- We always use a defensive approach, so if you miss a plugin it won't crash your config:
-- local ok_yourplugin, yourplugin = pcall(require, "yourplugin")
-- if your plugin then
-- TODO: add some references to recipes here

-- Mason {{{
local ok_mason, mason = pcall(require, "mason")
if ok_mason then
  mason.setup({
    ui = { border = "rounded" },
  })
end
-- }}}

-- Clangd extensions {{{
local ok_clangd_ext = pcall(require, "clangd_extensions")
if ok_clangd_ext then
  require("clangd_extensions").setup({
    inlay_hints = {
      inline = true,
    },
    ast = {
      role_icons = {
        type = "🄣",
        declaration = "🄓",
        expression = "🄔",
        statement = ";",
        specifier = "🄢",
        ["template argument"] = "🆃",
      },
      kind_icons = {
        Compound = "🄲",
        Recovery = "🅁",
        TranslationUnit = "🅄",
        PackExpansion = "🄿",
        TemplateTypeParm = "🅃",
        TemplateTemplateParm = "🅃",
        TemplateParamObject = "🅃",
      },
    },
  })
end
-- }}}

-- Oil {{{
local ok_oil, oil = pcall(require, "oil")
if ok_oil then
  local detail = false
  oil.setup({
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    watch_for_changes = true,
    columns = { "icon" },
    view_options = {
      show_hidden = true,
      natural_order = true,
    },
    win_options = {
      wrap = true,
    },
    preview_win = {
      update_on_cursor_moved = true,
      preview_method = "fast_scratch",
    },
    keymaps = {
      ["gd"] = {
        desc = "Toggle file detail view",
        callback = function()
          detail = not detail
          if detail then
            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
          else
            require("oil").set_columns({ "icon" })
          end
        end,
      },
      ["<Esc>"] = { "actions.close", mode = "n" },
    },
    float = {
      padding = 2,
      max_width = 0.9,
      max_height = 0.8,
      border = "rounded",
    },
  })
  map("n", "<leader>e", "<cmd>Oil --float<CR>", { desc = "File explorer" })
  map("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
end
-- }}}

-- Mini.pick {{{
local ok_pick = pcall(require, "mini.pick")
if ok_pick then
  require("mini.pick").setup({
    mappings = {
      move_down = "<C-j>",
      move_up = "<C-k>",
    },
    window = {
      config = { border = "rounded" },
    },
  })
end

local ok_extra = pcall(require, "mini.extra")
if ok_extra then
  require("mini.extra").setup()
end
-- }}}

-- Mini.pick helpers {{{

-- warn_about_roo_dir() sends a warning message and stops grepping
-- from the root directory
local function warn_about_root_dir(picker)
  local cwd = vim.fs.normalize(vim.fn.getcwd())
  local home = vim.fs.normalize(vim.env.HOME)
  if cwd == home and (picker == "grep_live" or picker == "files") then
    vim.notify("cd to a project first", vim.log.levels.WARN)
    return false
  end
end

-- pick_with_guard() helps making sure we are not grepping the entire root dir
local function pick_with_guard(picker, opts)
  opts = opts or {}

  warn_about_root_dir(picker)

  api.nvim_echo({ { " Searching...", "Comment" } }, false, {})

  vim.schedule(function()
    if picker == "oldfiles" or picker == "diagnostic" then
      require("mini.extra").pickers[picker](opts)
    else
      require("mini.pick").builtin[picker](opts)
    end
    vim.cmd("echo ''")
  end)
  return true
end

-- pick_from_dashboard() makes sure we are not grepping from the PureNvim dashboard
local function pick_from_dashboard(picker)
  return function()
    warn_about_root_dir(picker)

    vim.cmd("bdelete!")
    vim.defer_fn(function()
      if picker == "oldfiles" or picker == "diagnostic" then
        require("mini.extra").pickers[picker]()
      else
        require("mini.pick").builtin[picker]()
      end
    end, 50)
  end
end

map("n", "<leader>ff", function()
  pick_with_guard("files")
end, { desc = "Find files" })
map("n", "<leader>fg", function()
  pick_with_guard("grep_live")
end, { desc = "Live grep" })
map("n", "<leader>fb", function()
  pick_with_guard("buffers")
end, { desc = "Buffers" })
map("n", "<leader>fh", function()
  pick_with_guard("help")
end, { desc = "Help tags" })
map("n", "<leader>fr", function()
  pick_with_guard("oldfiles")
end, { desc = "Recent files" })
map("n", "<leader>fd", function()
  pick_with_guard("diagnostic")
end, { desc = "Diagnostics" })
-- }}}

-- Mini.starter {{{
local ok_starter = pcall(require, "mini.starter")
if ok_starter then
  require("mini.starter").setup({
    evaluate_single = true,
    footer = os.date(),
    -- NOTE: In case you want to change to a more general header
    -- header = table.concat({
    --   [[  /\ \▔\___  ___/\   /(●)_ __ ___  ]],
    --   [[ /  \/ / _ \/ _ \ \ / / | '_ ` _ \ ]],
    --   [[/ /\  /  __/ (_) \ V /| | | | | | |]],
    --   [[\_\ \/ \___|\___/ \_/ |_|_| |_| |_|]],
    --   [[───────────────────────────────────]],
    -- }, "\n"),
    header = table.concat({
      "╔═══════════════════════════════════════╗",
      "║             PURE NVIM                 ║",
      "║         SYSTEMS DEV                   ║",
      "║       C / C++ / Rust                  ║",
      "╚═══════════════════════════════════════╝",
    }, "\n"),
    items = {
      { name = "New Buffer",   action = "enew",                          section = "Builtin actions" },
      { name = "Recent files", action = pick_from_dashboard("oldfiles"), section = "Actions" },
      { name = "Config",       action = "e ~/.config/PureNvim/init.lua", section = "Actions" },
      { name = "Mason",        action = "Mason",                         section = "Plugins" },
      { name = "Quit",         action = "qall!",                         section = "Builtin actions" },
    },
  })
end
-- }}}

-- Mini utilities {{{
pcall(function()
  require("mini.pairs").setup()
end)
pcall(function()
  require("mini.surround").setup()
end)
-- }}}

-- Mini.ai {{{
local ok_ai, ai = pcall(require, "mini.ai")
if ok_ai then
  ai.setup({
    n_lines = 500,
    custom_textobjects = nil,
    mappings = {
      around = "a",
      inside = "i",
      around_next = "an",
      inside_next = "in",
      around_last = "al",
      inside_last = "il",
      goto_left = "g[",
      goto_right = "g]",
    },
  })
end
-- }}}

-- Mini.diff {{{
local ok_diff, diff = pcall(require, "mini.diff")
if ok_diff then
  diff.setup({
    view = {
      style = "sign",
      signs = { add = "│", change = "│", delete = "_" },
    },
  })
end
-- }}}

-- MiniJump2d {{{
-- INFO: Jump to characters similarly to Leap or Flash
local ok_jump2d, MiniJump2d = pcall(require, "mini.jump2d")
if ok_jump2d then
  MiniJump2d.setup({
    labels = "sdfghjklwertuiocvbnm",
    view = {
      dim = true,
      n_steps_ahead = 2,
    },
    allowed_windows = {
      current = true,
      not_current = false,
    },
    allowed_lines = {
      blank = false,
      fold = false,
    },
    mappings = {
      start_jumping = "",
    },
    silent = true,
  })

  vim.keymap.set(
    { "n", "x", "o" },
    "s",
    "<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>",
    { desc = "Jump to character" }
  )
end
-- }}}

-- mini.animate {{{
-- PERF: mini.animate
--  In case you want some nice effects without stressing your CPU
--  that much, use this and disable Smear
--  I recommend keeping mini off if you have Smear on
--  as the UI generally feels faster
-- require('mini.animate').setup()
-- }}}

-- Smear cursor {{{
local ok_smear, smear = pcall(require, "smear_cursor")
if ok_smear then
  smear.setup({
    stiffness = 0.8,
    trailing_stiffness = 0.6,
    damping = 0.95,
    distance_stop_animating = 0.5,
    -- PERF: the lower you go, the more CPU intensive it is
    time_interval = 8,

    smear_insert_mode = true,
    stiffness_insert_mode = 0.5,
    trailing_stiffness_insert_mode = 0.5,

    cursor_color = c.purple_bright,
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    legacy_computing_symbols_support = false,
  })
end
-- }}}

-- TODO COMMENTS {{{
-- INFO: TODO Comments
-- One of my favourite Folke's plugin, with a palette modified to match
-- Pastel Sorbet. A bit limited when it comes to search fanciness, as it would require
-- either Telescope and/or Plenary and I did want to keep it minimal.
-- TODO: explain how to jump with ]t and [t and to use <leader>fg for grepping
local ok_todo, todo = pcall(require, "todo-comments")
if ok_todo then
  todo.setup({
    signs = true,
    -- Big help from LazyVim icons and Folke's TODO
    -- https://www.lazyvim.org/configuration
    -- https://github.com/folke/todo-comments.nvim/blob/main/lua/todo-comments/config.lua
    keywords = {
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = "󰏚 ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", color = "perf", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      DOCS = { icon = " ", color = "docs", alt = { "TESTING", "PASSED", "FAILED" } },
    },

    colors = {
      error = { c.red_bright },
      warning = { c.yellow },
      info = { c.blue_bright },
      hint = { c.teal },
      perf = { c.purple_bright },
      test = { c.pink },
      docs = { c.purple_bright },
      default = { c.purple },
    },
    highlight = {
      multiline = true,
      before = "",
      keyword = "wide",
      after = "fg",
      pattern = [[.*<(KEYWORDS)\s*:]],
      comments_only = false,
    },
  })
end

map("n", "]t", function()
  todo.jump_next()
end, { desc = "Next todo" })
map("n", "[t", function()
  todo.jump_prev()
end, { desc = "Previous todo" })
-- }}}

-- CUSTOM SNIPPETS {{{
-- INFO: Native snippet system using vim.snippet (Neovim 0.10+)
--
-- DOCS: Usage
--   Type trigger word, press <Tab> to expand
--   <Tab> also accepts completion popup if visible
--   <leader>ls lists available snippets for current filetype
--
-- DOCS: Snippet Syntax (LSP format):
--   $0           Final cursor position
--   ${1:text}    Tabstop 1 with placeholder "text"
--   $1           Reference to tabstop 1 (mirrors input)
--   \n           Newline
--   \t           Tab (follows your indent settings)
--
-- DOCS: Adding Snippets
--   1. Find or create filetype key: snippets.yourft = {}
--   2. Add trigger = "body" pair
--   3. Use ["keyword"] bracket notation for Lua reserved words (if, for, while, etc.)
--
-- DOCS: Example:
--   snippets.python = {
--     ["def"] = "def ${1:name}(${2:args}):\n\t$0",
--     ["if"] = "if ${1:condition}:\n\t$0",

local snippets = {
  c = {
    main = "int main(int argc, char *argv[]) {\n\t$0\n\treturn 0;\n}",
    mainv = "int main(void) {\n\t$0\n\treturn 0;\n}",
    inc = '#include "${1:header}.h"',
    incs = "#include <${1:stdio}.h>",
    for_ = "for (int ${1:i} = 0; $1 < ${2:n}; $1++) {\n\t$0\n}",
    while_ = "while (${1:condition}) {\n\t$0\n}",
    if_ = "if (${1:condition}) {\n\t$0\n}",
    ife = "if (${1:condition}) {\n\t$2\n} else {\n\t$0\n}",
    struct = "typedef struct {\n\t$0\n} ${1:name}_t;",
    fn = "${1:void} ${2:name}(${3:void}) {\n\t$0\n}",
    pr = 'printf("${1:%s}\\n"${2:, $3});',
  },
  cpp = {
    main = "int main(int argc, char *argv[]) {\n\t$0\n\treturn 0;\n}",
    class = "class ${1:Name} {\npublic:\n\t$1();\n\t~$1();\nprivate:\n\t$0\n};",
    cout = 'std::cout << ${1:"text"} << std::endl;',
    cin = "std::cin >> ${1:var};",
  },
  rust = {
    main = "fn main() {\n\t$0\n}",
    fn_ = "fn ${1:name}(${2}) -> ${3:()} {\n\t$0\n}",
    pfn = "pub fn ${1:name}(${2}) -> ${3:()} {\n\t$0\n}",
    test = "#[test]\nfn ${1:test_name}() {\n\t$0\n}",
    impl = "impl ${1:Type} {\n\t$0\n}",
    struct = "struct ${1:Name} {\n\t$0\n}",
    enum_ = "enum ${1:Name} {\n\t$0\n}",
    let_ = "let ${1:name} = ${0};",
    letm = "let mut ${1:name} = ${0};",
    pr = 'println!("${1}");',
    prd = 'println!("{:?}", ${1});',
  },
  lua = {
    fn_ = "function ${1:name}(${2})\n\t$0\nend",
    lfn = "local function ${1:name}(${2})\n\t$0\nend",
    lf = "local ${1:name} = function(${2})\n\t$0\nend",
    if_ = "if ${1:condition} then\n\t$0\nend",
    ife = "if ${1:condition} then\n\t$2\nelse\n\t$0\nend",
    for_ = "for ${1:i} = ${2:1}, ${3:10} do\n\t$0\nend",
    forp = "for ${1:k}, ${2:v} in pairs(${3:table}) do\n\t$0\nend",
    fori = "for ${1:i}, ${2:v} in ipairs(${3:table}) do\n\t$0\nend",
    req = 'local ${1:mod} = require("${2:$1}")',
    pr = "print($0)",
  },
}
-- }}}

map("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    api.nvim_feedkeys(api.nvim_replace_termcodes("<C-y>", true, false, true), "n", false)
    return
  end

  local col = api.nvim_win_get_cursor(0)[2]
  local word = api.nvim_get_current_line():sub(1, col):match("(%w+)$")
  local snip = word and (snippets[vim.bo.filetype] or {})[word]

  if snip then
    local row = api.nvim_win_get_cursor(0)[1] - 1
    api.nvim_buf_set_text(0, row, col - #word, row, col, {})
    vim.snippet.expand(snip)
    return
  end

  api.nvim_feedkeys(api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
end, { desc = "Expand snippet or complete" })

map("n", "<leader>ls", function()
  local ft_snips = snippets[vim.bo.filetype]
  if not ft_snips then
    print("No snippets for " .. vim.bo.filetype)
    return
  end
  local lines = { "Snippets for " .. vim.bo.filetype .. ":" }
  for k, v in pairs(ft_snips) do
    lines[#lines + 1] = string.format("  %s → %s", k, v:gsub("\n", " "):sub(1, 50))
  end
  print(table.concat(lines, "\n"))
end, { desc = "List snippets" })
-- }}}

-- }}}

-- LSP {{{
-- INFO: Native LSP set up. I am a big proponent of keeping
-- all the little helps and nudges off by default, like autcompletion,
-- signature help, formatting on save etc.
-- I believe it helps memorizing syntax and understanding your code structure at a glance.
-- I have included jey-bindings to toggle them on/off as needed.
-- Autocompletion toggle {{{
g.lsp_autocompletion = false

local function toggle_autocompletion()
  g.lsp_autocompletion = not g.lsp_autocompletion
  vim.iter(vim.lsp.get_clients({ bufnr = 0 })):each(function(client)
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(g.lsp_autocompletion, client.id, 0, { autotrigger = true })
    end
  end)
  print("Autocompletion: " .. (g.lsp_autocompletion and "ON" or "OFF"))
end

map("n", "<leader>ta", toggle_autocompletion, { desc = "Toggle autocompletion" })
-- }}}

-- Format on save toggle {{{
-- WARN: OFF by default - you can format manually with <leader>lf
g.format_on_save = false

local function toggle_format_on_save()
  g.format_on_save = not g.format_on_save
  print("Format on save: " .. (g.format_on_save and "ON" or "OFF"))
end

map("n", "<leader>tf", toggle_format_on_save, { desc = "Toggle format on save" })

api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    if g.format_on_save then
      vim.lsp.buf.format({ async = false, timeout_ms = 1000 })
    end
  end,
})
-- }}}

-- Server configs {{{
-- INFO: C server
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders=true",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { "compile_commands.json", ".clangd", "Makefile", ".git" },
})

-- INFO: Rust server
vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" },
      cargo = { allFeatures = true },
      procMacro = { enable = true },
      inlayHints = {
        bindingModeHints = { enable = true },
        chainingHints = { enable = true },
        closingBraceHints = { enable = true },
        closureCaptureHints = { enable = true },
        closureReturnTypeHints = { enable = "always" },
        lifetimeElisionHints = { enable = "always" },
        parameterHints = { enable = true },
        typeHints = { enable = true },
      },
    },
  },
})

-- INFO: Lua server
vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { library = api.nvim_get_runtime_file("", true) },
      diagnostics = { globals = { "vim" } },
    },
  },
})
-- }}}

-- Enable servers {{{
pcall(vim.lsp.enable, { "clangd", "rust_analyzer", "lua_ls" })
-- }}}

---- Attach {{{
api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(args)
    local client = vim.lsp.get_clients({ id = args.data.client_id })[1]
    if not client then
      return
    end

    -- DOCS: COMPLETION
    -- https://neovim.io/doc/user/lsp.html#_lua-module:-vim.lsp.completion
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(g.lsp_autocompletion, client.id, args.buf, { autotrigger = true })
    end

    local opts = { buffer = args.buf }
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "[d", function()
      vim.diagnostic.jump({ count = -1 })
    end, opts)
    map("n", "]d", function()
      vim.diagnostic.jump({ count = 1 })
    end, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "<leader>lf", vim.lsp.buf.format, opts)
    map("n", "<leader>sr", vim.lsp.buf.references, opts)
    map("n", "<leader>sh", vim.lsp.buf.signature_help, opts)

    -- DIAGNOSTICS
    map("i", "<C-k>", vim.lsp.buf.signature_help, opts)
    map("n", "<leader>ld", vim.diagnostic.open_float, opts)
    map("n", "<leader>lt", function()
      local enabled = not vim.diagnostic.is_enabled()
      vim.diagnostic.enable(enabled)
      print("Diagnostics " .. (enabled and "enabled" or "disabled"))
    end, opts)
    map("n", "<leader>lh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
    end, opts)
  end,
})

-- All diagnostics to quickfix
map("n", "<leader>xx", function()
  vim.diagnostic.setqflist()
  vim.cmd("copen")
end, { desc = "All diagnostics (quickfix)" })

-- Buffer diagnostics only
map("n", "<leader>xX", function()
  vim.diagnostic.setloclist()
  vim.cmd("lopen")
end, { desc = "Buffer diagnostics (loclist)" })
--}}}

-- CODE ACTIONS {{{
-- INFO: Code Actions and suggestions pop ups are also native to Neovim and
-- aestehtically customised to Pastel Sorbet.
-- Completion popup border {{{
vim.api.nvim_create_autocmd("CompleteChanged", {
  group = augroup,
  callback = function()
    local info = vim.fn.complete_info({ "selected", "items" })
    if info.selected ~= -1 then
      return
    end
  end
})
-- }}}

-- Diagnostics {{{
vim.diagnostic.config({
  virtual_text = { prefix = " " },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
  underline = true,
  update_in_insert = true,
  float = { border = "rounded" },
})
-- }}}

-- Completion and signature auto-trigger {{{
api.nvim_create_autocmd("TextChangedI", {
  group = augroup,
  callback = function()
    if not g.lsp_autocompletion then return end

    local line = api.nvim_get_current_line()
    local col = api.nvim_win_get_cursor(0)[2]
    local char = line:sub(col, col)
    local before = line:sub(1, col)

    if char == "(" or char == "," then
      vim.lsp.buf.signature_help()
      return
    end

    if before:match("%w%w$") and vim.fn.pumvisible() == 0 then
      vim.lsp.completion.get()
    end
  end,
})
-- }}}

-- }}}
