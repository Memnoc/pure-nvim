# Oil.nvim Crash Course

Oil treats directories as buffers. You edit the filesystem like text.

## Opening Oil

| Key | Action |
|-----|--------|
| `-` | Open parent directory |
| `<leader>e` | Open float explorer |

## Navigation

| Key | Action |
|-----|--------|
| `<CR>` | Open file/directory |
| `-` | Go up one directory |
| `_` | Open cwd |
| `` ` `` | `:cd` to current directory |
| `~` | `:cd` to home |
| `g.` | Toggle hidden files |

## File Operations

### Create a file

1. Open Oil (`-` or `<leader>e`)
2. Press `o` to create new line (normal vim)
3. Type the filename: `newfile.c`
4. Press `<C-s>` to save (applies changes)

### Create a directory

1. Same as above, but end with `/`: `newdir/`
2. Save with `<C-s>`

### Rename

1. Put cursor on filename
2. Use `c$`, `cw`, or `C` to change the name
3. Save with `<C-s>`

### Delete

1. Delete the line: `dd`
2. Save with `<C-s>`

### Move

1. Delete line: `dd`
2. Navigate to target directory
3. Paste: `p`
4. Save with `<C-s>`

### Copy

1. Yank line: `yy`
2. Navigate to target directory
3. Paste: `p`
4. Rename the pasted entry (to avoid conflict if same dir)
5. Save with `<C-s>`

## Key Insight

Nothing happens until you save. Oil queues changes and shows you a preview. `<C-s>` executes them. To abort, just `:q!` without saving.

## Preview

| Key | Action |
|-----|--------|
| `<C-p>` | Preview file |
| `g?` | Show help |
