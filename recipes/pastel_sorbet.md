# Pastel Sorbet

A (bold) pastel colorscheme for Neovim, designed for me, and used as colorscheme of PureNvim.


## Design Philosophy

All color values tries to be original and with a unique identity to Pastel Sorbet.

Pastel Sorbet aims to be:

1. **Bold but soft** — High saturation without being too harsh
2. **Readable** — Decisive contrast between foreground and background
4. **Distinctive** — Each color has its own personality (if that's a thing)
5. **Warm** — Purple-tinted backgrounds because I like purple a lot

Pastel Sorbet follows  these principles:

1. **Warm purple-tinted backgrounds** — `#1c1826` base with `#14111c` for UI depth
2. **Bold pastels** — High lightness, controlled saturation
3. **Hue coherence** — Each color shifted to create family relationships
4. **No borrowed values** — Every hex code is original to this theme

## Palette values and codes

You can and are incouraged to use any of these values into your own colorscheme.
You also have full control inside the config in `init.lua` if you want to change something.

### Backgrounds

| Name | Hex | Usage |
|------|-----|-------|
| bg | `#1c1826` | Main editor background |
| bg_dark | `#14111c` | Darker UI elements (statusline, tabline) |
| bg_ui | `#2e2840` | UI highlights, visual selection |

### Foregrounds

| Name | Hex | Usage |
|------|-----|-------|
| fg | `#e8e4f2` | Main text |
| fg_dim | `#cdc8da` | Dimmed text, comments base |

### Greys

| Name | Hex | Usage |
|------|-----|-------|
| grey | `#726a88` | Comments, disabled text |
| grey_light | `#9c94b2` | Secondary information |
| linenr | `#4e4662` | Line numbers |

### Accent Colors

| Name | Hex | Description | Usage |
|------|-----|-------------|-------|
| red | `#ff8596` | Warm coral | Errors, deletions |
| red_bright | `#ffa0b0` | Soft coral | Error highlights |
| green | `#6ef298` | Fresh mint | Strings, additions |
| green_bright | `#52edb8` | Sea glass | String highlights |
| yellow | `#ffd85c` | Warm gold | Warnings, types |
| yellow_bright | `#ffe48a` | Pale gold | Warning highlights |
| blue | `#7db8ff` | Clear sky | Functions, links |
| blue_bright | `#a8d0ff` | Powder blue | Function highlights |
| purple | `#c88df7` | Deep violet | Keywords, statements |
| purple_bright | `#dba8ff` | Soft lavender | Keyword highlights |
| cyan | `#4cf0d8` | Electric aqua | Operators, special |
| cyan_bright | `#7af5e4` | Pale aqua | Operator highlights |
| pink | `#ff8ed0` | Bright rose | Special highlights |
| lime | `#b8f55c` | Acid green | Completion selection |
| teal | `#3df2c4` | Jade | Strings (alternative) |
| amber | `#ffa85c` | Rich orange | Constants, numbers |


## How to reference Pastel Sorbet in the config for full control
Place this in the HIGHLIGHTS section in `init.lua` and disable
```lua
  -- Colorscheme
  { src = "https://github.com/Memnoc/pastel-sorbet.nvim" },
```
```lua
-- local function set_highlights()
--  local hl = api.nvim_set_hl

  -- Treesitter base groups {{{
  -- hl(0, "Title", { fg = pastel_sorbet.yellow_bright, bold = true })
  -- hl(0, "@markup.heading", { fg = pastel_sorbet.yellow_bright, bold = true })
  -- hl(0, "@markup.link", { fg = pastel_sorbet.blue_bright, underline = true })
  -- hl(0, "@markup.link.label", { fg = pastel_sorbet.blue })
  -- hl(0, "@markup.raw", { fg = pastel_sorbet.green })
  -- hl(0, "@markup.raw.block", { fg = pastel_sorbet.green })
  -- hl(0, "@markup.italic", { italic = true })
  -- hl(0, "@markup.strong", { bold = true })
  -- hl(0, "@markup.list", { fg = pastel_sorbet.cyan })
  -- }}}

  -- Completion popup {{{
  -- hl(0, "Pmenu", { fg = pastel_sorbet.fg, bg = pastel_sorbet.bg_dark })
  -- hl(0, "PmenuSel", { fg = pastel_sorbet.bg, bg = pastel_sorbet.lime, bold = true })
  -- hl(0, "PmenuKind", { fg = pastel_sorbet.purple, bg = pastel_sorbet.bg_dark })
  -- hl(0, "PmenuKindSel", { fg = pastel_sorbet.bg, bg = pastel_sorbet.lime })
  -- hl(0, "PmenuExtra", { fg = pastel_sorbet.bg_dark, bg = pastel_sorbet.bg_dark })
  -- hl(0, "PmenuExtraSel", { fg = pastel_sorbet.lime, bg = pastel_sorbet.lime })
  -- hl(0, "PmenuSbar", { bg = pastel_sorbet.bg_dark })
  -- hl(0, "PmenuThumb", { bg = pastel_sorbet.purple })
  -- hl(0, "PmenuMatch", { fg = pastel_sorbet.purple_bright, bg = pastel_sorbet.bg_dark, bold = true })
  -- hl(0, "PmenuMatchSel", { fg = pastel_sorbet.bg, bg = pastel_sorbet.lime, bold = true })
  -- }}}

  -- Aesthetic {{{
  -- hl(0, "EndOfBuffer", { fg = pastel_sorbet.bg_ui })
  -- hl(0, "WinSeparator", { fg = pastel_sorbet.purple })
  -- }}}

  -- MiniJump2d {{{
  -- hl(0, "MiniJump2dSpot", { fg = "#ffffff", bg = "#875faf", bold = true, nocombine = true })
  -- hl(0, "MiniJump2dDim", { fg = "#444444", nocombine = true })
  -- }}}

  -- Tabline {{{
  -- hl(0, "TabLine", { fg = pastel_sorbet.grey, bg = pastel_sorbet.bg_dark })
  -- hl(0, "TabLineSel",
  --   { fg = pastel_sorbet.purple_bright, bg = pastel_sorbet.bg_dark, bold = true, sp = pastel_sorbet.purple, underline = true })
  -- hl(0, "TabLineFill", { bg = pastel_sorbet.bg_dark })
  -- }}}

  -- Statusline {{{
  -- hl(0, "StatusLine", { fg = pastel_sorbet.fg_dim, bg = pastel_sorbet.bg_dark })
  -- hl(0, "StatusLineNC", { fg = pastel_sorbet.grey, bg = pastel_sorbet.bg_dark })
  -- hl(0, "StatusLineBold", { fg = pastel_sorbet.fg, bg = pastel_sorbet.bg_dark, bold = true })
  -- hl(0, "StatusLineMode", { fg = pastel_sorbet.bg, bg = pastel_sorbet.purple, bold = true })
  -- hl(0, "StatusLineModeInsert", { fg = pastel_sorbet.bg, bg = pastel_sorbet.green, bold = true })
  -- hl(0, "StatusLineModeVisual", { fg = pastel_sorbet.bg, bg = pastel_sorbet.yellow, bold = true })
  -- hl(0, "StatusLineModeReplace", { fg = pastel_sorbet.bg, bg = pastel_sorbet.red, bold = true })
  -- hl(0, "StatusLineModeCommand", { fg = pastel_sorbet.bg, bg = pastel_sorbet.amber, bold = true })
  -- hl(0, "StatusLineGit", { fg = pastel_sorbet.purple_bright, bg = pastel_sorbet.bg_dark })
  -- hl(0, "StatusLineFile", { fg = pastel_sorbet.blue_bright, bg = pastel_sorbet.bg_dark })
  -- hl(0, "StatusLineFileType", { fg = pastel_sorbet.teal, bg = pastel_sorbet.bg_dark })
  -- hl(0, "StatusLinePos", { fg = pastel_sorbet.grey_light, bg = pastel_sorbet.bg_dark })
  -- hl(0, "StatusLineSep", { fg = pastel_sorbet.purple, bg = pastel_sorbet.bg_dark })
  -- }}}

  -- Float windows {{{
  -- hl(0, "NormalFloat", { fg = pastel_sorbet.fg_dim, bg = pastel_sorbet.bg_dark })
  -- hl(0, "FloatBorder", { fg = pastel_sorbet.purple, bg = pastel_sorbet.bg_dark })
  -- hl(0, "FloatTitle", { fg = pastel_sorbet.purple_bright, bg = pastel_sorbet.bg_dark, bold = true })
  -- }}}

  -- Winbar {{{
  -- hl(0, "WinBar", { fg = pastel_sorbet.fg_dim, bg = pastel_sorbet.bg_dark })
  -- hl(0, "WinBarNC", { fg = pastel_sorbet.grey, bg = pastel_sorbet.bg_dark })
  -- }}}

  -- Fold {{{
  -- hl(0, "Folded", { fg = pastel_sorbet.grey_light, bg = pastel_sorbet.bg_dark })
  -- hl(0, "FoldColumn", { fg = pastel_sorbet.linenr, bg = "NONE" })
  -- }}}

  -- Diagnostics {{{
  -- hl(0, "DiagnosticError", { fg = pastel_sorbet.red_bright })
  -- hl(0, "DiagnosticWarn", { fg = pastel_sorbet.yellow_bright })
  -- hl(0, "DiagnosticInfo", { fg = pastel_sorbet.blue_bright })
  -- hl(0, "DiagnosticHint", { fg = pastel_sorbet.cyan_bright })
  -- }}}

  -- Syntax overrides {{{
  -- hl(0, "Boolean", { fg = pastel_sorbet.amber })
  -- hl(0, "Number", { fg = pastel_sorbet.amber })
  -- hl(0, "Constant", { fg = pastel_sorbet.amber })
  -- hl(0, "String", { fg = pastel_sorbet.teal })
  -- hl(0, "Character", { fg = pastel_sorbet.green })
  -- hl(0, "Identifier", { fg = pastel_sorbet.fg })
  -- hl(0, "Function", { fg = pastel_sorbet.blue_bright })
  -- hl(0, "Statement", { fg = pastel_sorbet.purple_bright })
  -- hl(0, "Keyword", { fg = pastel_sorbet.purple_bright })
  -- hl(0, "Conditional", { fg = pastel_sorbet.purple_bright })
  -- hl(0, "Repeat", { fg = pastel_sorbet.purple_bright })
  -- hl(0, "Operator", { fg = pastel_sorbet.cyan_bright })
  -- hl(0, "Type", { fg = pastel_sorbet.blue_bright })
  -- hl(0, "StorageClass", { fg = pastel_sorbet.purple_bright })
  -- hl(0, "Structure", { fg = pastel_sorbet.blue_bright })
  -- hl(0, "PreProc", { fg = pastel_sorbet.cyan_bright })
  -- hl(0, "Include", { fg = pastel_sorbet.purple_bright })
  -- hl(0, "Define", { fg = pastel_sorbet.purple_bright })
  -- hl(0, "Comment", { fg = pastel_sorbet.grey, italic = true })
  -- hl(0, "Special", { fg = pastel_sorbet.cyan_bright })
  -- hl(0, "Delimiter", { fg = pastel_sorbet.fg_dim })
  -- }}}

  -- Base {{{
  -- hl(0, "Normal", { fg = pastel_sorbet.fg, bg = pastel_sorbet.bg })
  -- hl(0, "Visual", { bg = pastel_sorbet.bg_ui })
  -- hl(0, "CursorLine", { bg = pastel_sorbet.bg_ui })
  -- hl(0, "LineNr", { fg = pastel_sorbet.linenr })
  -- hl(0, "CursorLineNr", { fg = pastel_sorbet.yellow, bold = true })
  -- hl(0, "Search", { fg = pastel_sorbet.bg, bg = pastel_sorbet.yellow })
  -- hl(0, "IncSearch", { fg = pastel_sorbet.bg, bg = pastel_sorbet.amber })
  -- hl(0, "MatchParen", { fg = pastel_sorbet.amber, bold = true })
  -- hl(0, "NonText", { fg = pastel_sorbet.linenr })
  -- hl(0, "SpecialKey", { fg = pastel_sorbet.linenr })
  -- hl(0, "SignColumn", { bg = pastel_sorbet.bg })
  -- hl(0, "ColorColumn", { bg = pastel_sorbet.bg_ui })
  -- hl(0, "VertSplit", { fg = pastel_sorbet.purple })
  -- }}}
-- end

-- set_highlights()
```

## Some useful bits

### Highlight Group Mapping

Created a `set_highlights()` function that maps the palette to Neovim highlight groups:

```lua
local function set_highlights()
  local hl = api.nvim_set_hl
  
  -- Syntax
  hl(0, "String", { fg = pastel_sorbet.teal })
  hl(0, "Keyword", { fg = pastel_sorbet.purple_bright })
  hl(0, "Function", { fg = pastel_sorbet.blue_bright })
  -- ... etc
end
```

###  Iterative Refinement

I have tried, to the best of my knowledge, to make sure these colors work in various environments.
However, I acknowledge that much of it is tailored around what I like/work on, so things can be broken :)

Tested across:
- C/C++ syntax highlighting
- Lua configuration files
- Markdown documents
- Completion popups
- Statusline and tabline
- Diagnostic messages

Raise an issue/PR if you spot anything weird!

## How to change the values

The palette is defined in PureNvim's `init.lua` under the `-- THEME {{{` section. All colors are applied through the `set_highlights()` function in the `-- HIGHLIGHTS {{{` section.

To modify a color, update the value in the `pastel_sorbet` table and restart Neovim (or run `:source %` if editing the config).

## Color Families

This is something AI suggested, I thought it was cool!

For consistent theming, colors are grouped into families:

**Purple Family** (keywords, statements)
- `purple` (#c88df7), `purple_bright` (#dba8ff), `pink` (#ff8ed0)

**Blue Family** (functions, types)
- `blue` (#7db8ff), `blue_bright` (#a8d0ff)

**Cyan/Teal Family** (operators, strings)
- `cyan` (#4cf0d8), `cyan_bright` (#7af5e4), `teal` (#3df2c4)

**Green Family** (strings, additions)
- `green` (#6ef298), `green_bright` (#52edb8), `lime` (#b8f55c)

**Warm Family** (constants, warnings)
- `yellow` (#ffd85c), `yellow_bright` (#ffe48a), `amber` (#ffa85c)

**Red Family** (errors, deletions)
- `red` (#ff8596), `red_bright` (#ffa0b0)

## Credits

This colorscheme draws heavy inspiration from:

- **[Sorbet](https://github.com/vim/colorschemes)** — Neovim's built-in colorscheme, used as the base layer
- **[Tokyo Night](https://github.com/folke/tokyonight.nvim)** by [Folke Lemaitre](https://github.com/folke) — Inspiration for color relationships and structure

## License

This colorscheme is provided under the same license as PureNvim (MIT).

