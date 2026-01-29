-- INTRO {{{
-- You are reading the main (and only) config file of PureNvim.
-- PureNvim philosophy is giving the end user full control of the config with little to
-- no abstractions. This is why the Core systems it's almot entirely native Neovim API.
-- You may need to use a nightly version of Neovim. PureNvim was developed under Neovim 0.12.0.
-- To navigate the (long) configuration, make use of the -- SECTION MARKERS {{{}}}:
-- / to search
-- C-zR to fold all section markers
-- Space to open one section marker
-- C-zM to unfold all section markers
-- }}}

-- GLOBALS {{{
-- This is where your global values are grouped for efficiency and control.
-- Generally, do not touch these, unless you want to add something.
local o = vim.opt
local g = vim.g
local api = vim.api
local map = vim.keymap.set
local augroup = api.nvim_create_augroup("UserConfig", {})
-- }}}

-- PLUGINS {{{
-- Add your plugins here.
-- To add a language: https://github.com/Memnoc/pure-nvim/blob/main/recipes/add_language.md
vim.pack.add({
  -- Core
  { src = "https://github.com/echasnovski/mini.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },

  -- LSP
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/p00f/clangd_extensions.nvim" },

  -- Effects
  { src = "https://github.com/sphamba/smear-cursor.nvim" },
  { src = "https://github.com/karb94/neoscroll.nvim" },
})
-- }}}

-- PASTEL_SORBET {{{
-- The colorscheme of PureNvim!
-- Started as a slight variation on the stock theme Sorbet,
-- went through a TokyoNight Night phase, came out the other way
-- with a lot of both, and some touch of originality based on my personal taste.
-- TODO: add recipe on how to change the theme
local pastel_sorbet = {
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
-- }}}

-- OPTIONS {{{
-- Sane options and nothing more.
-- Took heavy inspirations from various configs, so don't be surprise if
-- you spot your favourite tech influencer settings here!
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
o.wrap = true
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
o.signcolumn = "yes"
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
o.fillchars = "vert: ,horiz: ,horizup: ,horizdown: ,vertleft: ,vertright: ,verthoriz: "
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

-- Kitty keyboard protocol fix {{{
vim.g.kitty_fast_forwarded_modifiers = "super"
-- }}}

-- }}}

-- HIGHLIGHTS {{{
-- This section is pure customization on various aspects of PureNvim.
-- You could, in theory, disable most of this without breaking anything,
-- However, being that PureNvim comes with a custom StatusLine and things of such nature,
-- disabling things here will most cetainly result in aestehtic ugliness (at best).
-- Make sure you do a borad search of these values throughout the config before
-- commenting or deleting something out!
local function set_highlights()
  local hl = api.nvim_set_hl

  -- Treesitter base groups {{{
  hl(0, "Title", { fg = pastel_sorbet.yellow_bright, bold = true })
  hl(0, "@markup.heading", { fg = pastel_sorbet.yellow_bright, bold = true })
  hl(0, "@markup.link", { fg = pastel_sorbet.blue_bright, underline = true })
  hl(0, "@markup.link.label", { fg = pastel_sorbet.blue })
  hl(0, "@markup.raw", { fg = pastel_sorbet.green })
  hl(0, "@markup.raw.block", { fg = pastel_sorbet.green })
  hl(0, "@markup.italic", { italic = true })
  hl(0, "@markup.strong", { bold = true })
  hl(0, "@markup.list", { fg = pastel_sorbet.cyan })
  -- }}}

  -- Completion popup {{{
  hl(0, "Pmenu", { fg = pastel_sorbet.fg, bg = pastel_sorbet.bg_dark })
  hl(0, "PmenuSel", { fg = pastel_sorbet.bg, bg = pastel_sorbet.lime, bold = true })
  hl(0, "PmenuKind", { fg = pastel_sorbet.purple, bg = pastel_sorbet.bg_dark })
  hl(0, "PmenuKindSel", { fg = pastel_sorbet.bg, bg = pastel_sorbet.lime })
  hl(0, "PmenuExtra", { fg = pastel_sorbet.bg_dark, bg = pastel_sorbet.bg_dark })
  hl(0, "PmenuExtraSel", { fg = pastel_sorbet.lime, bg = pastel_sorbet.lime })
  hl(0, "PmenuSbar", { bg = pastel_sorbet.bg_dark })
  hl(0, "PmenuThumb", { bg = pastel_sorbet.purple })
  hl(0, "PmenuMatch", { fg = pastel_sorbet.purple_bright, bg = pastel_sorbet.bg_dark, bold = true })
  hl(0, "PmenuMatchSel", { fg = pastel_sorbet.bg, bg = pastel_sorbet.lime, bold = true })
  -- }}}

  -- Aesthetic {{{
  hl(0, "EndOfBuffer", { fg = pastel_sorbet.bg_ui })
  hl(0, "WinSeparator", { fg = pastel_sorbet.purple })
  -- }}}

  -- MiniJump2d {{{
  hl(0, "MiniJump2dSpot", { fg = "#ffffff", bg = "#875faf", bold = true, nocombine = true })
  hl(0, "MiniJump2dDim", { fg = "#444444", nocombine = true })
  -- }}}

  -- Tabline {{{
  hl(0, "TabLine", { fg = pastel_sorbet.grey, bg = pastel_sorbet.bg_dark })
  hl(0, "TabLineSel",
    { fg = pastel_sorbet.purple_bright, bg = pastel_sorbet.bg_dark, bold = true, sp = pastel_sorbet.purple, underline = true })
  hl(0, "TabLineFill", { bg = pastel_sorbet.bg_dark })
  -- }}}

  -- Statusline {{{
  hl(0, "StatusLine", { fg = pastel_sorbet.fg_dim, bg = pastel_sorbet.bg_dark })
  hl(0, "StatusLineNC", { fg = pastel_sorbet.grey, bg = pastel_sorbet.bg_dark })
  hl(0, "StatusLineBold", { fg = pastel_sorbet.fg, bg = pastel_sorbet.bg_dark, bold = true })
  hl(0, "StatusLineMode", { fg = pastel_sorbet.bg, bg = pastel_sorbet.purple, bold = true })
  hl(0, "StatusLineModeInsert", { fg = pastel_sorbet.bg, bg = pastel_sorbet.green, bold = true })
  hl(0, "StatusLineModeVisual", { fg = pastel_sorbet.bg, bg = pastel_sorbet.yellow, bold = true })
  hl(0, "StatusLineModeReplace", { fg = pastel_sorbet.bg, bg = pastel_sorbet.red, bold = true })
  hl(0, "StatusLineModeCommand", { fg = pastel_sorbet.bg, bg = pastel_sorbet.amber, bold = true })
  hl(0, "StatusLineGit", { fg = pastel_sorbet.purple_bright, bg = pastel_sorbet.bg_dark })
  hl(0, "StatusLineFile", { fg = pastel_sorbet.blue_bright, bg = pastel_sorbet.bg_dark })
  hl(0, "StatusLineFileType", { fg = pastel_sorbet.teal, bg = pastel_sorbet.bg_dark })
  hl(0, "StatusLinePos", { fg = pastel_sorbet.grey_light, bg = pastel_sorbet.bg_dark })
  hl(0, "StatusLineSep", { fg = pastel_sorbet.purple, bg = pastel_sorbet.bg_dark })
  -- }}}

  -- Float windows {{{
  hl(0, "NormalFloat", { fg = pastel_sorbet.fg_dim, bg = pastel_sorbet.bg_dark })
  hl(0, "FloatBorder", { fg = pastel_sorbet.purple, bg = pastel_sorbet.bg_dark })
  hl(0, "FloatTitle", { fg = pastel_sorbet.purple_bright, bg = pastel_sorbet.bg_dark, bold = true })
  -- }}}

  -- Winbar {{{
  hl(0, "WinBar", { fg = pastel_sorbet.fg_dim, bg = pastel_sorbet.bg_dark })
  hl(0, "WinBarNC", { fg = pastel_sorbet.grey, bg = pastel_sorbet.bg_dark })
  -- }}}

  -- Fold {{{
  hl(0, "Folded", { fg = pastel_sorbet.grey_light, bg = pastel_sorbet.bg_dark })
  hl(0, "FoldColumn", { fg = pastel_sorbet.linenr, bg = "NONE" })
  -- }}}

  -- Diagnostics {{{
  hl(0, "DiagnosticError", { fg = pastel_sorbet.red_bright })
  hl(0, "DiagnosticWarn", { fg = pastel_sorbet.yellow_bright })
  hl(0, "DiagnosticInfo", { fg = pastel_sorbet.blue_bright })
  hl(0, "DiagnosticHint", { fg = pastel_sorbet.cyan_bright })
  -- }}}

  -- Syntax overrides {{{
  hl(0, "Boolean", { fg = pastel_sorbet.amber })
  hl(0, "Number", { fg = pastel_sorbet.amber })
  hl(0, "Constant", { fg = pastel_sorbet.amber })
  hl(0, "String", { fg = pastel_sorbet.teal })
  hl(0, "Character", { fg = pastel_sorbet.green })
  hl(0, "Identifier", { fg = pastel_sorbet.fg })
  hl(0, "Function", { fg = pastel_sorbet.blue_bright })
  hl(0, "Statement", { fg = pastel_sorbet.purple_bright })
  hl(0, "Keyword", { fg = pastel_sorbet.purple_bright })
  hl(0, "Conditional", { fg = pastel_sorbet.purple_bright })
  hl(0, "Repeat", { fg = pastel_sorbet.purple_bright })
  hl(0, "Operator", { fg = pastel_sorbet.cyan_bright })
  hl(0, "Type", { fg = pastel_sorbet.blue_bright })
  hl(0, "StorageClass", { fg = pastel_sorbet.purple_bright })
  hl(0, "Structure", { fg = pastel_sorbet.blue_bright })
  hl(0, "PreProc", { fg = pastel_sorbet.cyan_bright })
  hl(0, "Include", { fg = pastel_sorbet.purple_bright })
  hl(0, "Define", { fg = pastel_sorbet.purple_bright })
  hl(0, "Comment", { fg = pastel_sorbet.grey, italic = true })
  hl(0, "Special", { fg = pastel_sorbet.cyan_bright })
  hl(0, "Delimiter", { fg = pastel_sorbet.fg_dim })
  -- }}}

  -- Base {{{
  hl(0, "Normal", { fg = pastel_sorbet.fg, bg = pastel_sorbet.bg })
  hl(0, "Visual", { bg = pastel_sorbet.bg_ui })
  hl(0, "CursorLine", { bg = pastel_sorbet.bg_ui })
  hl(0, "LineNr", { fg = pastel_sorbet.linenr })
  hl(0, "CursorLineNr", { fg = pastel_sorbet.yellow, bold = true })
  hl(0, "Search", { fg = pastel_sorbet.bg, bg = pastel_sorbet.yellow })
  hl(0, "IncSearch", { fg = pastel_sorbet.bg, bg = pastel_sorbet.amber })
  hl(0, "MatchParen", { fg = pastel_sorbet.amber, bold = true })
  hl(0, "NonText", { fg = pastel_sorbet.linenr })
  hl(0, "SpecialKey", { fg = pastel_sorbet.linenr })
  hl(0, "SignColumn", { bg = pastel_sorbet.bg })
  hl(0, "ColorColumn", { bg = pastel_sorbet.bg_ui })
  hl(0, "VertSplit", { fg = pastel_sorbet.purple })
  -- }}}
end

set_highlights()

-- }}}

-- KEYMAPPINGS {{{
-- Most of the keymappings leave here. Some leave uner the plugins configurations,
-- and all (big lie) are listed here: https://github.com/Memnoc/pure-nvim/blob/main/README.md
g.mapleader = " "

-- General {{{
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<C-s>", "<cmd>write<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>write<CR>", { desc = "Save file and exit insert" })
map("n", "<leader>so", "<cmd>write | source %<CR>", { desc = "Save and source" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qall!<CR>", { desc = "Force quit all" })
-- }}}

-- Windows {{{
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
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
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
-- }}}

-- Move lines {{{
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
-- }}}

-- Better navigation {{{
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })
-- Check Neoscroll for this mapping
-- map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
-- map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search (centered)" })
-- }}}

-- Visual mode {{{
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })
map("v", "p", '"_dP', { desc = "Paste without yank" })
-- }}}

-- Comments {{{
map("n", "<leader>c", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<leader>c", "gc", { remap = true, desc = "Toggle comment" })
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
-- }}}

-- }}}

-- STATUSLINE {{{

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

-- Statusline function {{{
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

-- Auto-enable {{{
api.nvim_create_autocmd("FileType", {
  group = augroup,
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
-- }}}

-- Install helper {{{
function InstallParser(lang, repo, subpath)
  local data_dir = vim.fn.stdpath("data")
  local repo_name = repo:match("([^/]+)$")
  local clone_dir = data_dir .. "/" .. repo_name
  local src_dir = subpath and (clone_dir .. "/" .. subpath) or clone_dir

  if vim.fn.isdirectory(clone_dir) == 0 then
    print("Cloning " .. repo_name .. "...")
    vim.fn.system({ "git", "clone", "--depth=1", repo, clone_dir })
  end

  print("Compiling " .. lang .. " parser...")
  local compile_cmd = string.format(
    "cd %s && cc -shared -o %s.so -fPIC -I./src src/parser.c src/scanner.c 2>/dev/null || cc -shared -o %s.so -fPIC -I./src src/parser.c",
    src_dir, lang, lang
  )
  vim.fn.system(compile_cmd)

  vim.fn.system({ "mv", src_dir .. "/" .. lang .. ".so", data_dir .. "/parser/" })
  print("Installed " .. lang .. " parser. Restart Neovim.")
end

-- }}}

-- Parser auto-install {{{
local parsers_to_install = {
  { lang = "rust",            repo = "https://github.com/tree-sitter/tree-sitter-rust" },
  { lang = "cpp",             repo = "https://github.com/tree-sitter/tree-sitter-cpp" },
  { lang = "toml",            repo = "https://github.com/tree-sitter/tree-sitter-toml" },
  { lang = "json",            repo = "https://github.com/tree-sitter/tree-sitter-json" },
  { lang = "yaml",            repo = "https://github.com/tree-sitter-grammars/tree-sitter-yaml" },
  { lang = "markdown",        repo = "https://github.com/tree-sitter-grammars/tree-sitter-markdown", path = "tree-sitter-markdown" },
  { lang = "markdown_inline", repo = "https://github.com/tree-sitter-grammars/tree-sitter-markdown", path = "tree-sitter-markdown-inline" },
}

local function parser_installed(lang)
  local parser_path = vim.fn.stdpath("data") .. "/parser/" .. lang .. ".so"
  return vim.fn.filereadable(parser_path) == 1
end

local function install_missing_parsers()
  local missing = {}
  for _, p in ipairs(parsers_to_install) do
    if not parser_installed(p.lang) then
      table.insert(missing, p)
    end
  end

  if #missing == 0 then
    return
  end

  local choice = vim.fn.confirm(
    "Install " .. #missing .. " missing treesitter parsers? (" ..
    table.concat(vim.tbl_map(function(p) return p.lang end, missing), ", ") .. ")",
    "&Yes\n&No",
    1
  )

  if choice ~= 1 then
    return
  end

  for _, p in ipairs(missing) do
    InstallParser(p.lang, p.repo, p.path)
  end
end

api.nvim_create_autocmd("VimEnter", {
  group = augroup,
  once = true,
  callback = function()
    vim.defer_fn(install_missing_parsers, 100)
  end,
})
-- }}}

-- }}}

-- PLUGIN CONFIG {{{
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

-- Oil {{{
local ok_oil, oil = pcall(require, "oil")
if ok_oil then
  oil.setup({
    columns = { "icon" },
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 2,
      max_width = 0.4,
      max_height = 0.6,
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
local function pick_with_guard(picker, opts)
  opts = opts or {}
  local cwd = vim.fs.normalize(vim.fn.getcwd())
  local home = vim.fs.normalize(vim.env.HOME)

  if cwd == home and (picker == "grep_live" or picker == "files") then
    vim.notify("cd to a project first", vim.log.levels.WARN)
    return false
  end

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

local function pick_from_dashboard(picker)
  return function()
    local cwd = vim.fs.normalize(vim.fn.getcwd())
    local home = vim.fs.normalize(vim.env.HOME)

    if cwd == home and (picker == "grep_live" or picker == "files") then
      vim.notify("cd to a project first", vim.log.levels.WARN)
      return
    end

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

map("n", "<leader>ff", function() pick_with_guard("files") end, { desc = "Find files" })
map("n", "<leader>fg", function() pick_with_guard("grep_live") end, { desc = "Live grep" })
map("n", "<leader>fb", function() pick_with_guard("buffers") end, { desc = "Buffers" })
map("n", "<leader>fh", function() pick_with_guard("help") end, { desc = "Help tags" })
map("n", "<leader>fr", function() pick_with_guard("oldfiles") end, { desc = "Recent files" })
map("n", "<leader>fd", function() pick_with_guard("diagnostic") end, { desc = "Diagnostics" })
-- }}}

-- Mini.starter {{{
local ok_starter = pcall(require, "mini.starter")
if ok_starter then
  require("mini.starter").setup({
    header = table.concat({
      "╔═══════════════════════════════════════╗",
      "║             PURE NVIM                 ║",
      "║         SYSTEMS DEV                   ║",
      "║       C / C++ / Rust                  ║",
      "╚═══════════════════════════════════════╝",
    }, "\n"),
    items = {
      { name = "Find file",    action = pick_from_dashboard("files"),     section = "Actions" },
      { name = "Recent files", action = pick_from_dashboard("oldfiles"),  section = "Actions" },
      { name = "Grep",         action = pick_from_dashboard("grep_live"), section = "Actions" },
      { name = "Config",       action = "e ~/.config/PureNvim/init.lua",  section = "Actions" },
      { name = "Mason",        action = "Mason",                          section = "Actions" },
      { name = "Quit",         action = "qa",                             section = "Actions" },
    },
    footer = "",
  })
end
-- }}}

-- Mini utilities {{{
pcall(function() require("mini.pairs").setup() end)
pcall(function() require("mini.surround").setup() end)
pcall(function() require("mini.comment").setup() end)
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

  vim.keymap.set({ "n", "x", "o" }, "s",
    "<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>",
    { desc = "Jump to character" }
  )
end
-- }}}

-- mini.animate {{{
--  In case you want some nice effects without stressing your CPU
--  that much, use this and disable Neoscroll and Smear
-- require('mini.animate').setup()
-- }}}

-- Neoscroll {{{
local ok_neoscroll, neoscroll = pcall(require, "neoscroll")
if ok_neoscroll then
  neoscroll.setup({
    mappings = {
      '<C-u>', '<C-d>',
      '<C-b>', '<C-f>',
      '<C-y>', '<C-e>',
      'zt', 'zz', 'zb',
    },
    hide_cursor = true,
    stop_eof = true,
    respect_scrolloff = false,
    cursor_scrolls_alone = true,
    duration_multiplier = 1.0,
    easing = 'linear',
    pre_hook = nil,
    post_hook = nil,
    performance_mode = false,
    ignored_events = {
      'WinScrolled', 'CursorMoved'
    },
  })
end
-- }}}

-- Smear cursor {{{
local ok_smear, smear = pcall(require, "smear_cursor")
if ok_smear then
  smear.setup({
    stiffness = 0.8,
    trailing_stiffness = 0.6,
    damping = 0.95,
    distance_stop_animating = 0.5,
    -- time_interval = 7, -- the lower you go, the more CPU intensive it is

    smear_insert_mode = true,
    stiffness_insert_mode = 0.5,
    trailing_stiffness_insert_mode = 0.5,

    cursor_color = pastel_sorbet.purple_bright,
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    legacy_computing_symbols_support = false,
  })
end
-- }}}

-- clangd_extensions {{{
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

-- }}}

-- SNIPPETS {{{

local snippets = {
  c = {
    main = "int main(int argc, char *argv[]) {\n\t$0\n\treturn 0;\n}",
    mainv = "int main(void) {\n\t$0\n\treturn 0;\n}",
    inc = '#include "${1:header}.h"',
    incs = '#include <${1:stdio}.h>',
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

local function get_snippets()
  local ft = vim.bo.filetype
  return snippets[ft] or {}
end

local function expand_snippet_or_fallback()
  local line = api.nvim_get_current_line()
  local col = api.nvim_win_get_cursor(0)[2]
  local before = line:sub(1, col)
  local word = before:match("(%w+)$")

  if word then
    local ft_snippets = get_snippets()
    local snippet = ft_snippets[word] or ft_snippets[word .. "_"]
    if snippet then
      -- Delete the trigger word
      api.nvim_buf_set_text(0,
        api.nvim_win_get_cursor(0)[1] - 1,
        col - #word,
        api.nvim_win_get_cursor(0)[1] - 1,
        col,
        {}
      )
      vim.snippet.expand(snippet)
      return
    end
  end

  if vim.fn.pumvisible() == 1 then
    api.nvim_feedkeys(api.nvim_replace_termcodes("<C-y>", true, false, true), "n", false)
  else
    api.nvim_feedkeys(api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end

map("i", "<Tab>", expand_snippet_or_fallback, { desc = "Expand snippet or complete" })

-- Show available snippets {{{
local function show_snippets()
  local ft_snippets = get_snippets()
  if vim.tbl_isempty(ft_snippets) then
    print("No snippets for filetype: " .. vim.bo.filetype)
    return
  end

  local lines = { "Snippets for " .. vim.bo.filetype .. ":" }
  for trigger, body in pairs(ft_snippets) do
    local preview = body:gsub("\n", " "):gsub("%s+", " "):sub(1, 50)
    table.insert(lines, string.format("  %s → %s", trigger:gsub("_$", ""), preview))
  end

  print(table.concat(lines, "\n"))
end

map("n", "<leader>ls", show_snippets, { desc = "List snippets" })
-- }}}

-- }}}

-- LSP {{{

-- Autocompletion toggle {{{
g.lsp_autocompletion = true

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

-- Completion popup border {{{
vim.api.nvim_create_autocmd("CompleteChanged", {
  group = augroup,
  callback = function()
    local info = vim.fn.complete_info({ "selected", "items" })
    if info.selected ~= -1 then
      return
    end
  end,
})
-- }}}

-- Diagnostics {{{
vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "●",
      [vim.diagnostic.severity.WARN] = "●",
      [vim.diagnostic.severity.INFO] = "●",
      [vim.diagnostic.severity.HINT] = "●",
    },
  },
  underline = true,
  update_in_insert = false,
  float = { border = "rounded" },
})
-- }}}

---- Attach {{{
api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(args)
    local client = vim.lsp.get_clients({ id = args.data.client_id })[1]
    if not client then return end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    local opts = { buffer = args.buf }
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "<leader>lf", vim.lsp.buf.format, opts)
    map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)
    map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)
    map("n", "<leader>ld", vim.diagnostic.open_float, opts)
    map("n", "<leader>lt", function()
      vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    end, opts)
    map("n", "<leader>lh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
    end, opts)
  end,
})
-- }}}

-- Completion and signature auto-trigger {{{
api.nvim_create_autocmd("TextChangedI", {
  group = augroup,
  callback = function()
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
