-- GLOBALS {{{
local o = vim.opt
local g = vim.g
local api = vim.api
local map = vim.keymap.set
local augroup = api.nvim_create_augroup("UserConfig", {})
-- }}}

-- PLUGINS {{{
vim.pack.add({
  -- Core
  { src = "https://github.com/echasnovski/mini.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },

  -- LSP
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/p00f/clangd_extensions.nvim" },
})
-- }}}

-- THEME {{{
vim.cmd.colorscheme("sorbet")

local sorbet = {
  bg = "#000000",
  bg_dark = "#1a1b26",
  bg_ui = "#363841",
  fg = "#ffffff",
  fg_dim = "#dadada",
  grey = "#707070",
  grey_light = "#a6a8b1",
  linenr = "#585858",
  red = "#d75f5f",
  red_bright = "#ff5f5f",
  green = "#87d75f",
  green_bright = "#87ff5f",
  yellow = "#d7af5f",
  yellow_bright = "#ffd75f",
  blue = "#87afd7",
  blue_bright = "#87d7ff",
  purple = "#af87d7",
  purple_bright = "#d787ff",
  cyan = "#5fafaf",
  cyan_bright = "#5fd7d7",
  pink = "#ff00af",
  lime = "#afff00",
  teal = "#5fd7af",
  amber = "#ffaf00",
}
-- }}}

-- OPTIONS {{{

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

-- Spell {{{
o.spelllang = "en_us"
-- }}}

-- Kitty keyboard protocol fix {{{
vim.g.kitty_fast_forwarded_modifiers = "super"
-- }}}

-- }}}

-- HIGHLIGHTS {{{

-- Aesthetic {{{
api.nvim_set_hl(0, "EndOfBuffer", { fg = sorbet.bg_ui })
o.fillchars = "vert: ,horiz: ,horizup: ,horizdown: ,vertleft: ,vertright: ,verthoriz: "
api.nvim_set_hl(0, "WinSeparator", { fg = sorbet.purple })
-- }}}

-- MiniJump2d {{{
api.nvim_set_hl(0, "MiniJump2dSpot", { fg = "#ffffff", bg = "#875faf", bold = true, nocombine = true })
api.nvim_set_hl(0, "MiniJump2dDim", { fg = "#444444", nocombine = true })
-- }}}

-- Tabline {{{
api.nvim_set_hl(0, "TabLine", { fg = sorbet.grey_light, bg = sorbet.bg_dark })
api.nvim_set_hl(0, "TabLineSel", { fg = sorbet.fg, bg = sorbet.bg_ui, bold = true })
api.nvim_set_hl(0, "TabLineFill", { bg = sorbet.bg_dark })
-- }}}

-- Statusline {{{
api.nvim_set_hl(0, "StatusLine", { fg = sorbet.fg_dim, bg = sorbet.bg_dark })
api.nvim_set_hl(0, "StatusLineNC", { fg = sorbet.grey, bg = sorbet.bg_dark })
api.nvim_set_hl(0, "StatusLineBold", { fg = sorbet.fg, bg = sorbet.bg_dark, bold = true })
api.nvim_set_hl(0, "StatusLineMode", { fg = sorbet.bg, bg = sorbet.purple, bold = true })
api.nvim_set_hl(0, "StatusLineModeInsert", { fg = sorbet.bg, bg = sorbet.green, bold = true })
api.nvim_set_hl(0, "StatusLineModeVisual", { fg = sorbet.bg, bg = sorbet.yellow, bold = true })
api.nvim_set_hl(0, "StatusLineModeReplace", { fg = sorbet.bg, bg = sorbet.red, bold = true })
api.nvim_set_hl(0, "StatusLineModeCommand", { fg = sorbet.bg, bg = sorbet.amber, bold = true })
api.nvim_set_hl(0, "StatusLineGit", { fg = sorbet.purple_bright, bg = sorbet.bg_dark })
api.nvim_set_hl(0, "StatusLineFile", { fg = sorbet.blue_bright, bg = sorbet.bg_dark })
api.nvim_set_hl(0, "StatusLineFileType", { fg = sorbet.teal, bg = sorbet.bg_dark })
api.nvim_set_hl(0, "StatusLinePos", { fg = sorbet.grey_light, bg = sorbet.bg_dark })
api.nvim_set_hl(0, "StatusLineSep", { fg = sorbet.purple, bg = sorbet.bg_dark })
-- }}}

-- Float windows {{{
api.nvim_set_hl(0, "NormalFloat", { fg = sorbet.fg_dim, bg = sorbet.bg_dark })
api.nvim_set_hl(0, "FloatBorder", { fg = sorbet.purple, bg = sorbet.bg_dark })
api.nvim_set_hl(0, "FloatTitle", { fg = sorbet.purple_bright, bg = sorbet.bg_dark, bold = true })
-- }}}

-- Pmenu {{{
api.nvim_set_hl(0, "Pmenu", { fg = sorbet.fg_dim, bg = sorbet.bg_dark })
api.nvim_set_hl(0, "PmenuSel", { fg = sorbet.fg, bg = sorbet.bg_ui, bold = true })
api.nvim_set_hl(0, "PmenuSbar", { bg = sorbet.bg_ui })
api.nvim_set_hl(0, "PmenuThumb", { bg = sorbet.grey })
-- }}}

-- Winbar {{{
api.nvim_set_hl(0, "WinBar", { fg = sorbet.fg_dim, bg = sorbet.bg_dark })
api.nvim_set_hl(0, "WinBarNC", { fg = sorbet.grey, bg = sorbet.bg_dark })
-- }}}

-- Fold {{{
api.nvim_set_hl(0, "Folded", { fg = sorbet.grey_light, bg = sorbet.bg_dark })
api.nvim_set_hl(0, "FoldColumn", { fg = sorbet.linenr, bg = "NONE" })
-- }}}

-- Diagnostics {{{
api.nvim_set_hl(0, "DiagnosticError", { fg = sorbet.red_bright })
api.nvim_set_hl(0, "DiagnosticWarn", { fg = sorbet.yellow_bright })
api.nvim_set_hl(0, "DiagnosticInfo", { fg = sorbet.blue_bright })
api.nvim_set_hl(0, "DiagnosticHint", { fg = sorbet.cyan_bright })
-- }}}

-- }}}

-- KEYMAPPINGS {{{

g.mapleader = " "

-- General {{{
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<C-s>", "<cmd>write<CR>", { desc = "Save file" })
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
map("n", "<leader>c", "<cmd>close<CR>", { desc = "Close split" })
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
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search (centered)" })
-- }}}

-- Quick compile shortcuts for C/Rust {{{
map("n", "<leader>mc", "<cmd>!gcc -Wall -Wextra -g % -o %:r && ./%:r<CR>", { desc = "Compile & run C" })
map("n", "<leader>mr", "<cmd>!cargo run<CR>", { desc = "Cargo run" })
map("n", "<leader>mt", "<cmd>!cargo test<CR>", { desc = "Cargo test" })
map("n", "<leader>mb", "<cmd>!cargo build<CR>", { desc = "Cargo build" })
-- }}}

-- }}}

-- AUTOCMDS {{{

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

-- Create undo directory {{{
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
-- }}}

-- }}}

-- TERMINAL {{{

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
  local hl = mode_hl[mode] or "StatusLineMode"
  local name = mode_names[mode] or " " .. mode .. " "

  local parts = {
    "%#" .. hl .. "#" .. name,
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
function InstallParser(lang, repo)
  local cmd = string.format(
    "cd %s && git clone --depth=1 %s %s && cd %s && cc -shared -o %s.so -fPIC -I./src src/parser.c src/scanner.c 2>/dev/null || cc -shared -o %s.so -fPIC -I./src src/parser.c && mv %s.so %s/parser/",
    vim.fn.stdpath("data"),
    repo,
    "tree-sitter-" .. lang,
    "tree-sitter-" .. lang,
    lang,
    lang,
    lang,
    vim.fn.stdpath("data")
  )
  print("Installing " .. lang .. " parser...")
  vim.fn.system(cmd)
  print("Done. Restart Neovim to use the new parser.")
end

-- }}}

-- Parser auto-install {{{
local parsers_to_install = {
  { lang = "rust", repo = "https://github.com/tree-sitter/tree-sitter-rust" },
  { lang = "cpp",  repo = "https://github.com/tree-sitter/tree-sitter-cpp" },
  { lang = "toml", repo = "https://github.com/tree-sitter/tree-sitter-toml" },
  { lang = "json", repo = "https://github.com/tree-sitter/tree-sitter-json" },
  { lang = "yaml", repo = "https://github.com/tree-sitter-grammars/tree-sitter-yaml" },
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
    "Install "
    .. #missing
    .. " missing treesitter parsers? ("
    .. table.concat(
      vim.tbl_map(function(p)
        return p.lang
      end, missing),
      ", "
    )
    .. ")",
    "&Yes\n&No",
    1
  )

  if choice ~= 1 then
    return
  end

  for _, p in ipairs(missing) do
    InstallParser(p.lang, p.repo)
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup,
  once = true,
  callback = function()
    vim.defer_fn(install_missing_parsers, 100)
  end,
})
-- }}}

-- }}}

-- PLUGIN CONFIG {{{

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

-- Mini.pick helpers (MUST be defined before keymaps that use them) {{{
local function pick_with_guard(picker, opts)
  opts = opts or {}
  local cwd = vim.fs.normalize(vim.fn.getcwd())
  local home = vim.fs.normalize(vim.env.HOME)

  if cwd == home and (picker == "grep_live" or picker == "files") then
    vim.notify("cd to a project first", vim.log.levels.WARN)
    return false
  end

  vim.api.nvim_echo({ { " Searching...", "Comment" } }, false, {})

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

-- Picker keymaps (defined here because they need pick_with_guard)
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
      " ",
      " SYSTEMS DEV ",
      " C / C++ / Rust ",
      " ",
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
pcall(function()
  require("mini.pairs").setup()
end)
pcall(function()
  require("mini.surround").setup()
end)
pcall(function()
  require("mini.comment").setup()
end)
-- }}}

-- Mini.ai (enhanced text objects) {{{
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

-- Mini.diff (git signs in signcolumn) {{{
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

-- MiniJump2d (optimized) {{{
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

-- LSP {{{

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

-- Attach {{{
api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    local opts = { buffer = args.buf }
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "<leader>lf", vim.lsp.buf.format, opts)
    map("n", "[d", vim.diagnostic.goto_prev, opts)
    map("n", "]d", vim.diagnostic.goto_next, opts)
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

-- Diagnostics {{{
vim.diagnostic.config({
  virtual_text = { prefix = " " },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
  underline = true,
  update_in_insert = false,
  float = { border = "rounded" },
})
-- }}}

-- }}}
