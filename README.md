# neovim

## Setup

```sh
# clone this config
git clone https://github.com/yandy/neovim-config.git ~/.config/nvim

# install neccessary tools/packages
sudo pacman -S neovim wl-clipboard luarocks lldb lazygit

# invoke nvim and wait for install completion
nvim

# for markview
## make sure installed tar, curl, gcc, cargo
cargo install tree-sitter-cli
uv tool install mmdc
sudo pacman -S tectonic
```

## usage

### basic

**mode switch**
- `i` Insert text before the cursor
- `a` Append text after the cursor
- `o` Begin a new line below the cursor and insert text
- `v` enter visual mode
- `V` enter line selection visual mode
- `<c-q>` enter block visual mode

**visual block**
- `I{string}<ESC>` insert {string} at the start of block on every line of the block, provided that the line extends into the block.
- `A{string}<ESC>` append {string} at the start of block on every line of the block, provided that the line extends into the block.

**range** `:h [range]`
It consideredts of one or more line specifiers, separated with ',' or ';'.

When separated with ';' the cursor position will be set to that line before interpreting the next line specifier.  This doesn't happen for ','.
Examples:
   `4,/this line/` from line 4 till match with "this line" after the cursor line. >
   `5;/that line/` from line 5 till match with "that line" after line 5.
line number specified with:
- `{number}` an absolute line number
- `.`  the current line
- `$`  the last line of the buffer
- `%`  equal to 1,$ (the entire buffer)
- `/{pattern}[/]` the next line where {pattern} matches
- `?{pattern}[?]` the previous line where {pattern} matches

**motion** `:h navigation`
- `h`/`j`/`k`/`l` left/down/up/right
- `:[range]` Set the cursor on the last line number in \[range\].
- `{count}%` Go to {count} percentage in the file
- `gg` begin of current buffer
- `G` end of current buffer
- `0` begin of line
- `$` end of line
- `^` first non-blank of line
- `<c-f>`/`<c-b>` page down/up
- `<c-d>`/`<c-u>` half page down/up
- `e`/`b` \[count\] forward/backward word
- `}`/`{` \[count\] paragraphs forward/backward
- `]]`/`[[` \[count\] sections forward/backward
- `m{a-zA-Z}` Set mark {a-zA-Z} at cursor position (`'a`-`'z` valid within one file; `'A`-`'Z` valid between files)
- `g'{mark}` Jump to the {mark}, but don't change the jumplist when jumping within the current buffer.
- `<c-o>` Go to \[count\] Older cursor position in jump list
- `<c-i>` Go to \[count\] newer cursor position in jump list
- `<c-]>` follow the links in help text
- `gx` Opens the current filepath, URL (decided by `<cfile>`, 'isfname'), or `LSP` "documentLink" at cursor using the system default handler.
- `{Visual}gx` Opens the selected text using the system default handler.

**deleting** `:h deleting`
- `x` Delete a character under the cursor
- `{Visual}["x]d` Delete the highlighted text [into register x] (for {Visual})
- `["x]d{motion}` Delete text that {motion} moves over [into register x]
- `["x]dd` Delete \[count\] lines [into register x]

**replacing** `:h replacing`
- `{Visual}["x]c` Delete the highlighted text [into register x] and start insert (for {Visual})
- `["x]c{motion}` Delete text that {motion} moves over [into register x]
- `["x]cc` Delete \[count\] lines [into register x]

**changing** `:h changing`
- `r{char}` Replace the character under the cursor with {char}
- `{Visual}r{char}` Replace every highlighted characters with {char}
- `~` Switch case of the character under the cursor and move the cursor to the right.
- `{Visual}~` Switch case of highlighted text
- `{Visual}U` Make highlighted text uppercase
- `{Visual}u` Make highlighted text lowercase
- `gcc` Comment or uncomment \[count\] lines starting at cursor.
- `{Visual}gc` Comment or uncomment the selected line(s).

**shift-left-right** `:h shift-left-right`
- `{Visual}[count]<` Shift the highlighted lines \[count\] 'shiftwidth' leftwards
- `<<` Shift \[count\] lines one 'shiftwidth' leftwards.
- `{Visual}[count]>` Shift the highlighted lines \[count\] 'shiftwidth' rightwards
- `>>` Shift \[count\] lines one 'shiftwidth' rightwards.

**substitute** `:h :substitute`
`:[range]s[ubstitute]/{pattern}/{string}/[flags] [count]`:

For each line in \[range\] replace a match of {pattern} with {string}.

*`[flags]`* :
`[c]`   Confirm each substitution.  Vim highlights the matching string      
        'y'     to substitute this match
        'n'     to skip this match
        'a'     to substitute this and all remaining matches
        <Esc>   to quit substituting
        'l'     to substitute this match and then quit ("last")
        'q'     to quit substituting
`[g]`   Replace all occurrences in the line.  Without this argument,
    replacement occurs only for the first occurrence in each line.  If the
    'gdefault' option is on, this flag is on by default and the [g]
    argument switches it off.   

**change-tabs** `:h change-tabs`
- `:ret[ab][!]` Replace all sequences of white-space containing a <Tab> with 'tabstop'

**copy-move** `:h copy-move`
- `"{register}` Use {register} for next delete, yank or put
- `:reg[isters]` show all registers
- `{Visual}["x]y` Yank the highlighted text [into registerx]
- `["x]yy` Yank \[count\] lines [into register x]
- `["x]p`/`["x]P` Put the text [from register x] after/before the cursor \[count\] times.

**undo-redo-repeat** `:h undo-redo` `:h repeating`
- `u` Undo \[count\] changes.
- `<c-r>` Redo \[count\] changes which were undone.
- `.` repeat last change
- `:[range]g[lobal]/{pattern}/[cmd]` Execute the Ex command \[cmd\] (default ":p") on the lines within \[range\] where {pattern} matches.

**folding**
- `zR` open all folds
- `zr` open 1-level folds
- `zM` close all folds
- `zm` close 1-level folds
- `za` toggle fold

**window** `:h window`
- `:sp` Split current window in two.
- `:vs` Split current window in two. spread out horizontally
- `:wq` save and quit
- `:q!` quit without save
- `:q` quit if no changes in buffer
- `<c-w>h`/`<c-w>j`/`<c-w>k`/`<c-w>l` switch to left/down/up/right window
- `<c-w>w` cycle window
- `<c-w> +`/`<c-w> -` Increase/Decrease current window height by N (default 1).
- `<c-w> >`/`<c-w> <` Increase/Decrease current window width by N (default 1).

**lsp**
- `<leader>th` toggle inlay hints
- `<a-s-f>` format current buffer
- `gra` code action
- `gri` goto implementation
- `grn` rename symbol
- `grr` goto references
- `grt` goto type definition
- `grx` codelens run
- `gO` list current buffer symbols
- `gd` goto definition

**other**
- `:options` Open a window for viewing and setting all options. see `:h options`


### plugins

**buffer**
- `<leader>bn` next bufferline
- `<leader>bp` previous bufferline
- `<leader>bc` close all other buffer
- `<leader>bd` close current buffer

**snacks** `:h snacks`
- `<a-h>` toggle hidden files
- `<a-i>` toggle ignored files

**snacks.picker**`:h snacks-picker`
- `<leader><space>` smart find
- `<leader>/` grep files
- `<leader>ff` find in files
- `<leader>fb` find in buffers
- `<leader>fr` find in recent files
- `<leader>fg` find in git log
- `<leader>fh` find in help
- `<leader>fk` find in keymap
- `<leader>fc` find in vim config

- `<leader>ld` diagnostics
- `<leader>lD` buffer diagnostics

**snacks.explorer** `:h snacks-explorer`
- `<leader>e` open explorer
- file(s) operation
    - `r` rename current file
    - `d` delete current/selected files
    - `a` add new file or directory (directories end with `/`)
    - `<cr>`/`l` open file or toggle directory
    - `o` open file with system application 
- move/copy files
    1. Select files with <Tab> (works on multiple files)
    2. Navigate to the target directory
    3. Execute the operation:
        - `m` move selected files to the target directory
        - `c` copy selected files to the target directory
- tree operation
    - `u` refresh the file tree
    - `h` close directory
    - `Z` close all directories
    - `P` toggle preview

**snacks.terminal**
- ```<c-`>``` open terminal
- ```<c-s-`>``` new terminal

**snacks.lazygit**
- `<leader>G` open lazygit

**blink.cmp** `:help blink-cmp.txt`
- `<c-n>` select next
- `<c-p>` select previous
- `<tab>`/`<c-y>` select and accept
- `<c-e>` cancle/hidden
- `<c-f>` scroll documentation down
- `<c-b>` scroll documentation up

**markview** `:help markview.nvim`
- `<leader>mt` toggles markdown render.
- `<leader>mp` preview markdown by side

**img-clip** `:help img-clip.nvim-img-clip.nvim-configuration`
- `<leader>P` Paste image from system clipboard
- *DRAG AND DROP* drag images from the web browser or file explorer into the terminal to automatically embed them, in `normal` mode.

**agentic.nvim** [docs](https://github.com/carlos-algms/agentic.nvim)
- `<c-.>` toggle agentic widget
- `<localleader>r` rotate agentic chat layout
- `q` close agentic widget
- `<s-tab>` change mode (eg. plan, build)
- `<localLeader>s` switch acp provider
- `<localLeader>m` switch model
- `<localLeader>t` switch think level
- `<c-s>` submit prompt
- `<c-'>` add file or selection to agentic context
- `<c-/>` add all buffer diagnostics to agentic
- `{Insert}<c-v>`/`<localLeader>p` paste image
- `<esc><esc>` interrupt generation
- `<localleader>n` new agentic session
- `<localleader>l` list agentic session for restore
- `<a-c-f>` scroll agentic page down
- `<a-c-b>` scroll agentic page up
- `]]` next heading
- `[[` previous heading

**debug** `:help dap.txt`, `:help dap-launch.json`
Supported languages: Python, C/C++, JavaScript, TypeScript

- `<leader>db` / `<F9>` toggle breakpoint
- `<leader>dD` / `<S-F9>` clear breakpoints
- `<leader>ds` / `<F5>` start/continue debugging
- `<leader>do` / `<F10>` step over
- `<leader>di` / `<F11>` step into
- `<leader>dO` / `<S-F11>` step out
- `<leader>dQ` / `<S-F5>` terminate session
- `<leader>dB>` set conditional breakpoint (with input prompt)
- `<leader>du>` toggle dapui

## plugin management (vim.pack)

Plugins are managed by Neovim's built-in `vim.pack` (`:h vim.pack`, see `lua/plugins/*.lua`).
Plugins live in `~/.local/share/nvim/site/pack/core/opt`, and the resolved revisions are
recorded in `nvim-pack-lock.json` at the repo root (keep it under version control).

Startup only *aligns* state, it never upgrades: plugins listed in `nvim-pack-lock.json` but
missing on disk are installed at the lockfile revision, while plugins already on disk are
left untouched (no `git fetch`, no `git checkout`, current revision is not even checked).
Upgrading is always an explicit action.

### upgrade plugins (all)

```vim
:lua vim.pack.update()
```

`vim.pack.update()` downloads new changes from every source and computes the newest revision
matching each plugin's `version` constraint (or the default branch when `version` is unset).
A confirmation buffer opens in a separate tabpage:

- changes to be applied are prefixed with `>`, reversions with `<`
- `:write` confirms and applies the updates
- `:quit` discards them
- `]]`/`[[` navigate between plugin sections, `gO` lists them (`vim.lsp.buf.document_symbol()`)
- `gra` offers plugin-specific code actions, e.g. "update", "skip updating", "delete"
- `:lua vim.pack.update(nil, { force = true })` skips the confirmation buffer

Every applied update is also logged to `nvim-pack.log` under the "log" standard path
(`~/.local/state/nvim/nvim-pack.log`). Run `:restart` afterwards to start using the new code.

Upgrade only a subset, and inspect the current state without downloading anything:

```vim
:lua vim.pack.update({ 'snacks.nvim', 'blink.cmp' })
:lua vim.pack.update(nil, { offline = true })
```

### synchronize across devices

`nvim-pack-lock.json` is the source of truth for exact revisions, so pushing it is what makes
another device reproduce the same plugin set.

On the device that made the changes:

```sh
git add nvim-pack-lock.json && git commit -m 'chore: bump plugins' && git push
```

On the other device:

1. `git pull`, then `:restart` — plugins present in the lockfile but not yet on disk are
   installed directly at the lockfile revision.
2. Pin every already-installed plugin to the lockfile revision:

   ```vim
   :lua vim.pack.update(nil, { target = 'lockfile' })
   ```

   Read the confirmation buffer and `:write` to apply. With `target = 'lockfile'` the target
   revision comes from the lockfile instead of "newest matching `version`", which is what
   keeps both devices identical (also the way to revert a plugin after an update).
3. Remove plugins that were dropped from the config and are therefore no longer in the
   lockfile — they are not deleted automatically. Find them with the lockfile diff, then:

   ```vim
   :lua vim.pack.del({ 'plugin-name' })
   ```

   `vim.pack.get()` returns all managed plugins; filter on `not x.active` to spot leftovers.

Note on `offline`: it skips `git fetch` and only makes sense when the target revision already
exists locally (e.g. after switching `version` in `lua/plugins/*.lua`, or when reverting).
Do **not** pass `offline = true` right after `git pull` on a fresh device — the lockfile
revision may not be in the local object database yet and `git checkout` would fail.

Revert an unwanted update:

```sh
git checkout HEAD -- nvim-pack-lock.json
```

```vim
:restart
:lua vim.pack.update({ 'plugin-name' }, { offline = true, target = 'lockfile' })
```
