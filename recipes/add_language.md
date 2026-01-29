# Adding Language Support

PureNvim uses native Neovim 0.12+ treesitter support with manual parser installation.

## Adding a New Language

### Step 1: Find the Grammar Repository

Official grammars: https://github.com/tree-sitter
Community grammars: https://github.com/tree-sitter-grammars

### Step 2: Add to Parser List

In `init.lua`, find `parsers_to_install` and add an entry:

```lua
local parsers_to_install = {
  -- Existing parsers...
  { lang = "cpp",             repo = "https://github.com/tree-sitter/tree-sitter-cpp" },
}
```
### Step 3: Restart Neovim

On restart, you'll be prompted to install missing parsers. Feel free to spam your Enter key in a very
impatient fashion. Generally, the parsers to get installed, and you can check that in your 
`~/.local/share/nvim/parser/` dir in your system (on Linux, cannot remeber MacOS, don't even ask about Windows)

## Special Cases: Multi-Grammar Repos

Some repos contain multiple grammars in subdirectories (e.g., markdown, which drove me insane).
Check the repo structure. If sources are in subdirectories:

```lua
{ lang = "markdown", repo = "https://github.com/tree-sitter-grammars/tree-sitter-markdown", path = "tree-sitter-markdown" },
{ lang = "markdown_inline", repo = "https://github.com/tree-sitter-grammars/tree-sitter-markdown", path = "tree-sitter-markdown-inline" },
```
The `path` parameter tells the installer which subdirectory contains `src/parser.c`.

## Troubleshooting

### No Syntax Highlighting

Work through this (pain) checklist in order.

#### 1. Check Parser Exists

```bash
ls ~/.local/share/nvim/parser/
```
You should see `<lang>.so` for your language. 
If missing, installation failed—check for compiler errors by running the compile command manually.

#### 2. Check Parser Works

Open a file of that language and run:

```vim
:InspectTree
```
If you see a syntax tree, the parser works. If error, parser isn't loading correctly.

#### 3. Check Highlighter is Active

```vim
:lua print(vim.inspect(vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()]))
```
Should return a table with `true` values. If `nil`, treesitter highlighting isn't attached.

Try manually starting it (like a car):

```vim
:lua vim.treesitter.start()
```
#### 4. Check Highlight Queries Exist

This one is obscure as hell. AI told me to do it, and it's kind of useful so here's some 
slop for ya.

```vim
:lua print(vim.treesitter.query.get('<lang>', 'highlights'))
```

Replace `<lang>` with your language. Should return a table address. 
If `nil`, no highlight queries found—you may need to copy them from the grammar repo to `~/.local/share/nvim/queries/<lang>/`.

#### 5. Check Capture Groups Have Colors

This one drove me insane. Incidentally, it's also why I have put hours in creating Pastel Sorbet.

Put cursor on unhighlighted text and run:

```vim
:Inspect
```
This shows treesitter captures. Example output:

```
Treesitter
  - @keyword.return.c links to Statement
```
Follow the breadcrumb from here:

```vim
:highlight Statement
```
If it shows `cleared` or links to another group, keep following until you find the problem (good luck to you <3).

#### 6. Fix Missing Highlight Groups

I have tried my best (and so did Claude) to include anything you may need, but if I missed (a lot of) something:

If a group is `cleared`, add it to the `set_highlights()` function in `init.lua`:

```lua
hl(0, "Statement", { fg = sorbet.purple })
```

### Common Highlight Groups

These core groups cover most languages (I work with):

| Group | Used For |
|-------|----------|
| `Statement` | Keywords (return, if, else) |
| `Keyword` | Language keywords |
| `Function` | Function names |
| `Type` | Type names |
| `String` | String literals |
| `Comment` | Comments |
| `Constant` | Constants, numbers |
| `Identifier` | Variables |
| `PreProc` | Preprocessor directives |
| `Special` | Special characters |
| `Title` | Headings (markdown) |

### Filetype Not Detected

You'll find these functions under Server Configs, conveniently grouped. You should know you can apparently
pass more than one language, as such:

```vim
  filetypes = { "c", "cpp", "objc", "objcpp" },
```
If `:set filetype?` returns empty or wrong value:

```vim
:set filetype=<lang>
```
This will save your mental health.

For permanent fix, add to `init.lua` and it **should** work:

```lua
vim.filetype.add({
  extension = {
    xyz = "mylang",
  },
})
```

## Manual Parser Installation

This is another AI non-sense, but I am including it for completeness and because you're maybe savvier
than me and can actually do this properly.

If auto-install fails, compile manually:

```bash
cd ~/.local/share/nvim
git clone --depth=1 <repo-url>
cd <repo-name>
cc -shared -o <lang>.so -fPIC -I./src src/parser.c src/scanner.c
# If scanner.c doesn't exist:
cc -shared -o <lang>.so -fPIC -I./src src/parser.c
mv <lang>.so ~/.local/share/nvim/parser/
```

Restart Neovim after installation.
