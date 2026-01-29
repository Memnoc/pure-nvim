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

