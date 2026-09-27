# The Field Guide to This Neovim Config

Everything this config does, what each key is for, and when you'd actually reach for it.

You don't need to read this top to bottom. Read **[Start here](#start-here)**,
then skim the rest when you're wondering "is there a key for that?" (there usually is).

> **Leader = `Space`.** Whenever you see `<leader>f`, press `Space` then `f`.
>
> **Can't remember a key?** Press `Space` and **wait**. which-key pops up
> and shows you every option. This works for `g`, `[`, `]`, `z`, `"` and more too.
> Can't remember *which group* it's in? `Space s k` fuzzy-searches **every** keymap.

---

## Contents

1. [Start here: the 10 keys that matter most](#start-here)
2. [Moving around files](#moving-around-files): Telescope, oil, harpoon
3. [Editing superpowers](#editing-superpowers): surround, text objects, comments, selection
4. [Code intelligence](#code-intelligence): LSP, completion, diagnostics, formatting
5. [Rust](#rust): rustaceanvim + crates
6. [Git](#git): gitsigns, Neogit, Diffview
7. [Windows, terminal & misc](#windows-terminal--misc)
8. [A day in the life](#a-day-in-the-life): real workflows
9. [Keeping it running](#keeping-it-running): updates, Mason, health
10. [Changing the config](#changing-the-config): where everything lives
11. [Cheat sheet](#cheat-sheet)

---

## Start here

If you learn nothing else, learn these. They cover about 80% of daily use.

| Keys | What it does |
|---|---|
| `Space Space` | Switch between open buffers |
| `Space s f` | **Find a file** by name |
| `Space s g` | **Grep** the whole project for text |
| `-` | Open the **file explorer** (oil) for the current file's folder |
| `grd` | **Go to definition** (back with `Ctrl-t` or `Ctrl-o`) |
| `grr` | **Find references** |
| `K` | Show docs / type info for the thing under the cursor |
| `gra` | **Code actions** (quick fixes, imports, refactors) |
| `]d` / `[d` | Jump to next / previous **error** (the message pops up automatically) |
| `Space g g` | **Git** status: stage, commit, push |

Then there's one habit worth building: **`Space s k`** whenever you think "there must be a
key for this".

---

## Moving around files

You have three tools here, and each is for a different job:

- **Telescope**: "I know roughly what I'm looking for" → *search*
- **oil**: "I want to look around / create / rename / move files" → *browse & edit*
- **harpoon**: "I keep bouncing between the same 3–4 files" → *bookmark*

### Telescope: fuzzy find everything

All searches live under `Space s` ("search").

| Keys | Search for... |
|---|---|
| `Space s f` | Files by name |
| `Space s g` | Text in the whole project (live grep) |
| `Space s w` | The word under the cursor (or the selection, in visual mode) |
| `Space s /` | Text, but only in open files |
| `Space /` | Text in the **current** buffer |
| `Space s .` | Recently opened files |
| `Space Space` | Open buffers |
| `Space s d` | Diagnostics (errors/warnings) |
| `Space s h` | Neovim `:help` pages, which is really useful |
| `Space s k` | Keymaps |
| `Space s c` | Commands |
| `Space s n` | Files in *this config* |
| `Space s s` | ...every Telescope picker (there are dozens) |
| `Space s r` | **Resume** the last search right where you left it |

**Inside a picker:**

| Keys | Action |
|---|---|
| type | Filter (fuzzy: `mrs` matches `main.rs`) |
| `Ctrl-n` / `Ctrl-p` | Move down / up |
| `Enter` | Open |
| `Ctrl-x` / `Ctrl-v` / `Ctrl-t` | Open in horizontal split / vertical split / tab |
| `Ctrl-q` | Send **all results** to the quickfix list (see the [grep-and-fix workflow](#a-day-in-the-life)) |
| `Ctrl-/` (insert) or `?` (normal) | Show all picker keys |
| `Esc Esc` | Close |

### oil: the file explorer that's just a buffer

Press **`-`** and you're looking at the current file's folder. Here's the trick:
**the listing is a normal text buffer.** You manage files by *editing text*:

| To... | Do this, then `:w` |
|---|---|
| Rename a file | Edit its name (e.g. `cw`) |
| Delete a file | `dd` the line |
| Create a file | Add a new line with the name (`o` → `notes.md`) |
| Create a folder | Add a line ending in `/` (`o` → `utils/`) |
| Move a file | `dd` it, go into another folder, `p` it |
| Copy a file | `yy` it, go to another folder, `p` it |

When you `:w`, oil shows you a summary of what it's about to do and asks to confirm.
Nothing happens to the disk until then, so experimenting is safe.

| Keys (inside oil) | Action |
|---|---|
| `Enter` | Open file / enter folder |
| `-` | Go up to the parent folder |
| `_` | Jump to Neovim's working directory |
| `Ctrl-p` | Preview the file under cursor |
| `Ctrl-s` / `Ctrl-x` / `Ctrl-t` | Open in vertical split / horizontal split / tab |
| `Ctrl-r` | Refresh |
| `g.` | Toggle hidden (dot) files. They're **shown** by default |
| `gs` | Change sort order |
| `gx` | Open with the system app (browser, image viewer, ...) |
| `Ctrl-c` | Close oil |
| `g?` | Help: all oil keys |

`nvim .` also opens oil, since it replaces the built-in netrw explorer.

### harpoon: bookmarks for your working set

When you're working on a feature you usually live in 3–4 files. Instead of
searching for them over and over, *pin* them:

| Keys | Action |
|---|---|
| `Space a` | **Add** the current file to the list |
| `Space 1` ... `Space 4` | Jump straight to file 1–4 |
| `Space e` | Open the harpoon **menu** |

The menu is also just a buffer: reorder with `dd`/`p`, delete lines to unpin,
`Enter` to open, `q` or `Esc` to close. Changes are saved automatically.
Harpoon lists are **per project**, so each repo keeps its own set.

---

## Editing superpowers

### Surround (mini.surround): add, change, delete brackets & quotes

Everything starts with `s`:

| Keys | Before → After |
|---|---|
| `saiw)` | `hello` → `(hello)` : **s**urround **a**dd **i**nner **w**ord with `)` |
| `saiw"` | `hello` → `"hello"` |
| `sd"` | `"hello"` → `hello` : **s**urround **d**elete `"` |
| `sr)]` | `(hello)` → `[hello]` : **s**urround **r**eplace `)` with `]` |
| `sa` in visual mode | Surround the selection |
| `sh)` | Highlight the surrounding `)` pair |
| `sf)` / `sF)` | Jump to the right / left `)` of the surrounding pair |

`)` gives `(x)`, while `(` gives `( x )` with spaces. Same for `]`/`[` and `}`/`{`.
`t` lets you type an HTML tag, and `f` asks for a function name: `saiwf` + `print` → `print(hello)`.

### Text objects (mini.ai): smarter `ci(`, `da"` and friends

Vim's `ci(` ("change inside parentheses") gets a big upgrade:

| Keys | Selects |
|---|---|
| `i(` `a(` / `ib` `ab` | Inside / around parens. `b` = *any* bracket: `()`, `[]` or `{}` |
| `iq` `aq` | Inside / around *any* quote: `"`, `'` or `` ` `` |
| `if` `af` | Inside / around a **function call**: `foo(a, b)` |
| `it` `at` | Inside / around an HTML/XML tag |
| `ii(` / `aa(` | ...the **next** `(` on the line, even if you're not inside one |
| `il(` / `al(` | ...the **last** (previous) `(` |

They work **from a distance**: with the cursor at the start of `let x = foo("bar");`,
`ciq` jumps forward and changes `bar`. Combine with any operator: `d`, `c`, `y`, `v`.

### Comments (built-in)

| Keys | Action |
|---|---|
| `gcc` | Toggle comment on the current line |
| `gc` + motion | Toggle comments, e.g. `gcip` (paragraph), `gc3j` |
| `gc` in visual mode | Toggle comments on the selection |

### Grow the selection (Treesitter, built-in)

In visual mode, select by **syntax** instead of characters:

| Keys (visual mode) | Action |
|---|---|
| `an` | Expand to the **parent** node (expression → statement → block → function...) |
| `in` | Shrink back to a **child** node |
| `]n` / `[n` | Select next / previous node |

Try it: put the cursor on a variable, press `v`, then `an` a few times.

### Misc editing niceties

| Keys | Action |
|---|---|
| `Esc` | Clear search highlighting |
| `]Space` / `[Space` | Add an empty line below / above |
| `Y` | Yank to end of line (like `D` and `C`) |
| `*` / `#` in visual mode | Search for the selected text |
| `gx` | Open the URL/path under the cursor in the browser/system app |

Also handy: the system clipboard is shared (`y` copies to it, `p` pastes from it),
undo history survives closing the file, and `:%s/foo/bar` previews
replacements live in a split while you type.

---

## Code intelligence

### LSP: navigation & refactoring

These work whenever a language server is attached to the buffer (Lua, Rust, and
whatever else you add). Most live under `gr`, so press `gr` and wait to see them.

| Keys | Action |
|---|---|
| `grd` | Go to **definition** |
| `grr` | Find **references** (Telescope list) |
| `gri` | Go to **implementation** |
| `grt` | Go to **type** definition |
| `grD` | Go to **declaration** (e.g. the C header, not the definition) |
| `grn` | **Rename** symbol across the project |
| `gra` | **Code action**: fixes, imports, refactors (also works on a visual selection) |
| `grx` | Run the code lens under the cursor |
| `gO` | Fuzzy search **symbols in this file** |
| `gW` | Fuzzy search **symbols in the whole project** |
| `K` | Hover docs (press `K` again to jump *into* the popup) |
| `Ctrl-s` (insert mode) | Signature help: what arguments does this function take? |
| `Space t h` | Toggle **inlay hints** (inline type annotations) |
| `Ctrl-o` / `Ctrl-i` | Jump back / forward after a go-to |

When the cursor rests on a symbol, every other use of it in the file gets highlighted.
The progress spinner in the bottom-right corner is **fidget**, which shows what the
language server is doing (indexing, checking...).

### Autocompletion (blink.cmp)

The completion menu pops up as you type (LSP suggestions, file paths, snippets).

| Keys (insert mode) | Action |
|---|---|
| `Ctrl-y` | **Accept** ("yes"). This also auto-imports and expands snippets |
| `Ctrl-n` / `Ctrl-p` or `↓` / `↑` | Next / previous item |
| `Ctrl-Space` | Open the menu, or show docs for the selected item |
| `Ctrl-e` | Close the menu |
| `Ctrl-k` | Toggle signature help |
| `Tab` / `Shift-Tab` | Jump to the next / previous placeholder in an expanded snippet |

> Why `Ctrl-y` and not `Tab`/`Enter`? So you never accidentally accept a completion
> when you just wanted a newline or indent. It feels odd for a day, then you won't
> want it any other way. (You can change the preset in `lua/plugins/blink.lua`.)

### Diagnostics: errors & warnings

Errors show at the end of the line. You have **four ways** to look at them, from
smallest to largest:

| Keys | Scope |
|---|---|
| `Ctrl-w d` | Show the full message under the cursor in a float |
| `]d` / `[d` | Jump to next / previous. The float opens automatically |
| `]D` / `[D` | Jump to the last / first one in the buffer |
| `Space s d` | Fuzzy-search all diagnostics (Telescope) |
| `Space q` | Put this buffer's diagnostics in the location list |
| `Space x x` | **Trouble**: a proper panel of every diagnostic in the project |

### Trouble: a better list for everything

Trouble is a panel at the bottom that lists problems, symbols or references, grouped
by file, and keeps them updated as you work. It's great when a change breaks 12 places.

| Keys | Opens |
|---|---|
| `Space x x` | All diagnostics in the project |
| `Space x X` | Diagnostics in the current buffer only |
| `Space x s` | Symbols outline of the current file (functions, structs...) |
| `Space x l` | LSP definitions / references / implementations for the symbol under cursor |
| `Space x Q` | The quickfix list, but prettier |
| `Space x L` | The location list |

Each key **toggles**: press it again to close.

| Keys (inside Trouble) | Action |
|---|---|
| `Enter` | Jump to the item |
| `o` | Jump **and** close Trouble |
| `p` / `P` | Preview the item / toggle auto-preview |
| `]]` / `[[` or `}` / `{` | Next / previous item |
| `s` | Cycle the severity filter (errors only → warnings → ...) |
| `gb` | Toggle "current buffer only" |
| `za` / `zM` / `zR` | Toggle fold / close all / open all |
| `q` | Close |
| `?` | Help |

### Formatting (conform.nvim)

| Keys | Action |
|---|---|
| `Space f` | Format the buffer (or the selection in visual mode) |

**Rust files format automatically on save** with `rustfmt`. For other languages
`Space f` uses the language server's formatter. To turn on format-on-save for
more filetypes, edit `format_on_save_filetypes` in `lua/plugins/conform.lua`.

---

## Rust

### rustaceanvim: rust-analyzer, tuned up

Rust is set up via **rustaceanvim** instead of plain `rust_analyzer`. You get everything
from [Code intelligence](#code-intelligence), plus:

| Keys (Rust files) | Action |
|---|---|
| `Space r r` | **Run** something: pick a binary, example or bench from a list |
| `Space r t` | **Test** something: pick a test / test module to run |
| `Space r e` | **Expand macro** under the cursor: see what `#[derive]`/`vec!` generates |
| `K` | Hover **with actions**: docs plus links like "go to impl" and "run" |

Also: **clippy** runs on save instead of plain `cargo check`, so you get lint
warnings inline, and files are formatted with `rustfmt` on save.

There's more under `:RustLsp` (tab-complete it), e.g. `:RustLsp explainError`,
`:RustLsp openDocs` (docs.rs for the symbol under the cursor), `:RustLsp openCargo`,
`:RustLsp parentModule`.

### crates.nvim: manage `Cargo.toml` from inside it

Open any `Cargo.toml`. Next to each dependency you'll see whether it's up to date.
Completion for **crate names, versions and features** comes up in the normal
completion menu.

| Keys (`Cargo.toml` only) | Action |
|---|---|
| `K` | Crate info popup (description, links, versions) |
| `gra` | Code actions: update, upgrade, open docs... |
| `Space c v` | Show all **versions**, then pick one to use |
| `Space c f` | Show / toggle **features** |
| `Space c d` | Show the crate's **dependencies** |
| `Space c u` | **Update** the crate (latest compatible, e.g. `1.0.100` → `1.0.219`) |
| `Space c U` | **Upgrade** the crate (latest overall, may be a breaking bump) |
| `Space c a` / `Space c A` | Update / upgrade **all** crates |
| `Space c D` | Open docs.rs |
| `Space c C` | Open crates.io |

`Space c u` / `Space c U` also work on a visual selection of several lines.

---

## Git

Three tools, from small to big:

- **gitsigns**: see & handle changes **line by line**, right in the file
- **Neogit**: full git workflow (stage, commit, push, branch, rebase...) in one screen
- **Diffview**: review **whole changesets** side by side, file history, merge conflicts

### gitsigns: changes in the gutter

The left column shows `+` added, `~` changed, `_` deleted lines. A block of changed
lines is a **hunk**, and hunk keys live under `Space h`.

| Keys | Action |
|---|---|
| `]c` / `[c` | Jump to next / previous changed hunk |
| `Space h p` | **Preview** the hunk (what did I change here?) |
| `Space h i` | Preview the hunk inline |
| `Space h s` | **Stage** the hunk (or the selected lines, in visual mode) |
| `Space h r` | **Reset** the hunk, throwing the change away (or selected lines) |
| `Space h S` / `Space h R` | Stage / reset the **whole file** |
| `Space h b` | **Blame** the current line (who / when / which commit) |
| `Space h d` / `Space h D` | Diff this file against the index / the last commit |
| `Space h q` / `Space h Q` | All hunks in this file / whole repo to the quickfix list |
| `Space t b` | Toggle inline blame on every line |
| `Space t w` | Toggle word-level diff highlighting |
| `ih` | Text object: "this hunk", e.g. `vih`, `dih` |

### Neogit: your git command center

`Space g g` opens the status screen: untracked, unstaged and staged changes, plus recent
commits. **Every action is one key**, and `?` shows them all.

| Keys | Action |
|---|---|
| `Space g g` | Open status |
| `Space g c` | Straight to the commit menu |
| `Space g l` | Straight to the log menu |

**In the status screen:**

| Keys | Action |
|---|---|
| `Tab` | Expand / collapse a file (shows its diff inline) |
| `s` | **Stage** file or hunk under cursor (works on visual selections of lines too) |
| `u` | **Unstage** |
| `S` / `U` | Stage all unstaged / unstage all staged |
| `x` | **Discard** changes (asks first) |
| `Enter` | Open the file |
| `Ctrl-n` / `Ctrl-p` | Jump to the next / previous section |
| `q` | Close |

**The menus.** Press a letter to open a menu, then a letter to act. Flags like
`-a` or `--force` show up at the top of each menu, and you toggle them by typing them.

| Menu | Common follow-up |
|---|---|
| `c` **Commit** | `c` commit, `a` amend, `e` extend (amend without editing message), `w` reword |
| `P` **Push** | `p` to push-remote, `u` to upstream |
| `p` **Pull** | `p` / `u` same idea |
| `f` **Fetch** | `a` all remotes |
| `b` **Branch** | `b` checkout, `c` create & checkout, `m` rename, `D` delete |
| `l` **Log** | `l` current branch, `b` all branches |
| `Z` **Stash** | `z` stash, `p` pop, `a` apply |
| `r` **Rebase** | `i` interactive, `e` onto elsewhere. Mid-rebase: `r` continue, `s` skip, `a` abort |
| `m` **Merge** · `d` **Diff** (opens Diffview) · `A` cherry-pick · `X` reset · `t` tag | |

**Writing the commit message:** a buffer opens, so write the message and then press
**`Ctrl-c Ctrl-c`** to commit, or **`Ctrl-c Ctrl-k`** to abort. (`:wq` also commits.)

### Diffview: review everything side by side

| Keys | Action |
|---|---|
| `Space g d` | Open a diff of **all current changes** vs. the last commit |
| `Space g h` | **History of the current file**: every commit that touched it |
| `Space g H` | History of the **whole repo** |
| `Space g q` | Close Diffview |

`:DiffviewOpen main` diffs your working tree against `main`, and
`:DiffviewOpen main...HEAD` shows only what your branch changed, which is handy
before opening a PR.

| Keys (inside Diffview) | Action |
|---|---|
| `Tab` / `Shift-Tab` | Next / previous file |
| `j` / `k` + `Enter` | Pick a file in the side panel |
| `-` or `s` | Stage / unstage the file |
| `S` / `U` | Stage all / unstage all |
| `X` | Restore the file (discard changes) |
| `Space b` | Toggle the file panel |
| `Space e` | Focus the file panel (overrides harpoon's `Space e` here) |
| `g Ctrl-x` | Cycle layouts (side-by-side, stacked...) |
| `g?` | Help |

**Merge conflicts.** When a merge or rebase stops with conflicts, `Space g d` shows
each conflicted file in a 3-way view:

| Keys | Action |
|---|---|
| `]x` / `[x` | Next / previous conflict |
| `Space c o` | Take **ours** |
| `Space c t` | Take **theirs** |
| `Space c b` | Take the **base** |
| `Space c a` | Take **all** versions (then clean up by hand) |
| `dx` | Delete the conflict region entirely |
| `Space c O` / `T` / `B` / `A` | Same as above, for **every** conflict in the file |

(Inside Diffview `Space c` means conflicts. In `Cargo.toml` it means crates.)

---

## Windows, terminal & misc

| Keys | Action |
|---|---|
| `Ctrl-h` / `j` / `k` / `l` | Move to the window left / below / above / right |
| `:vsplit` / `:split` (or `Ctrl-w v` / `Ctrl-w s`) | Split vertically / horizontally |
| `Ctrl-w q` | Close window |
| `Ctrl-w =` | Make all windows equal size |
| `]b` / `[b` | Next / previous buffer |
| `]q` / `[q` | Next / previous quickfix item |
| `:terminal` | Open a terminal in the current window |
| `Esc Esc` | Leave terminal mode (back to normal mode, so you can scroll/yank) |
| `i` | Go back into typing in the terminal |

The mouse works too, e.g. drag window borders to resize. Quitting with unsaved
changes asks whether to save instead of throwing an error.

**Markdown rendering.** `.md` files (like this guide) render right in the buffer:
headings, tables, code blocks, checkboxes. The line under your cursor switches back to
raw text so you can edit it. `Space t m` toggles rendering on/off, and
`:RenderMarkdown preview` opens a rendered copy side by side. Typing `- [` in a list
suggests checkboxes in the completion menu.

**Todo comments.** `TODO:`, `FIXME:`, `NOTE:`, `HACK:`, `WARN:` and `PERF:` in
comments get highlighted. `:TodoTelescope` lists them all across the project, and
`:TodoTrouble` does the same in Trouble.

---

## A day in the life

**Starting on a feature**
1. `nvim .`, which opens oil in the project root
2. `Space s f` → find the file you need
3. Found the 3 files you'll be living in? `Space a` on each, then jump with `Space 1/2/3`

**Understanding unfamiliar code**
1. `K` on anything you don't recognize
2. `grd` to dive in, `Ctrl-o` to come back out
3. `grr` to see who uses it, `Space x s` for an outline of the file

**Renaming something everywhere**
1. Cursor on the name → `grn` → type new name → `Enter`. Done, across all files.

**Grep-and-fix across the project** (e.g. replace an old API)
1. `Space s g` → type `old_function`
2. `Ctrl-q` sends every match to the quickfix list
3. `:cdo s/old_function/new_function/g | update`, which edits every match and saves
   (or step through by hand with `]q` / `[q`, or view them with `Space x Q`)

**"cargo build" broke 20 places**
1. `Space x x` → Trouble lists every error grouped by file
2. `Enter` on each, fix, and watch them disappear from the list

**Bumping a dependency**
1. `Space s f` → `Cargo.toml`
2. Cursor on the crate → `Space c v` → pick a version, or `Space c u`

**Committing your work**
1. `Space g d` to review the full diff, `Space g q` to close
2. `Space g g` → `s` on what you want to stage (or `Tab` into a file and `s` single hunks)
3. `c` `c` → write message → `Ctrl-c Ctrl-c`
4. `P` `u` to push

**"Who wrote this and why?"**
1. `Space h b`: blame for the line
2. `Space g h`: every commit that ever touched this file

---

## Keeping it running

### Plugins: `vim.pack`, built into Neovim

| Command | What it does |
|---|---|
| `:lua vim.pack.update()` | **Update all plugins.** Opens a review buffer: `:w` to apply, `:q` to cancel |
| `:lua vim.pack.update(nil, { offline = true })` | See plugin state without downloading anything |
| `:lua vim.pack.del { 'name' }` | Remove an installed plugin (delete its file first, see below) |

Exact versions are recorded in `nvim-pack-lock.json`. Commit it, and every machine you
clone this config onto gets the same versions.

### Language servers & tools: Mason

| Command | What it does |
|---|---|
| `:Mason` | See installed servers/formatters/linters, install more (`i`), update (`u`), `g?` for help |

Anything in the `servers` list in `lua/plugins/lsp.lua` is installed automatically.

### When something feels broken

| Command | Checks |
|---|---|
| `:checkhealth` | Everything (long) |
| `:checkhealth vim.lsp` | Which language servers are attached and why / why not |
| `:checkhealth which-key` | Conflicting keymaps |
| `:checkhealth crates` / `diffview` / `kickstart` | Individual plugins |
| `:messages` | Recent errors and notifications |
| `:TSUpdate` | Update Treesitter parsers (fixes broken highlighting) |

---

## Changing the config

```
init.lua                  ← entry point, just loads the rest
lua/config/
  options.lua             ← editor settings (line numbers, clipboard, Nerd Font toggle...)
  keymaps.lua             ← general keymaps
  autocmds.lua            ← automatic actions (highlight on yank)
  diagnostics.lua         ← how errors are displayed
  pack.lua                ← build steps some plugins need after install
lua/plugins/
  init.lua                ← THE LIST of plugins, in load order
  <plugin>.lua            ← one file per plugin: install + setup + its keymaps
```

**Quick tweaks**
- **Icons everywhere:** set `vim.g.have_nerd_font = true` in `lua/config/options.lua`
  (needs a Nerd Font in your terminal)
- **Different theme style:** `tokyonight-night` → `-storm`, `-moon` or `-day` in
  `lua/plugins/colorscheme.lua`
- **Tab accepts completions:** `preset = 'super-tab'` in `lua/plugins/blink.lua`
- **Add a language server:** add it to `servers` in `lua/plugins/lsp.lua`
  (e.g. `pyright = {}`, `gopls = {}`). Mason installs it on the next start.
- **Format on save for more languages:** `format_on_save_filetypes` in `lua/plugins/conform.lua`
- **Error messages under the line instead of at the end:** swap `virtual_text` /
  `virtual_lines` in `lua/config/diagnostics.lua`

**Adding a plugin**
1. Create `lua/plugins/my-plugin.lua`:
   ```lua
   vim.pack.add { 'https://github.com/author/my-plugin.nvim' }
   require('my-plugin').setup {}
   vim.keymap.set('n', '<leader>m', '<cmd>MyPlugin<CR>', { desc = '[M]y plugin' })
   ```
2. Add `require 'plugins.my-plugin'` to `lua/plugins/init.lua`
3. Restart Neovim. It asks to install, and you say yes.

Before picking a key, check it's free with `Space s k`.

**Removing a plugin:** delete its file and its line in `lua/plugins/init.lua`, restart,
then `:lua vim.pack.del { 'plugin-name' }`.

There are also ready-made (disabled) extras in `lua/kickstart/plugins/`: a debugger,
indent guides, a linter, autopairs and neo-tree. Uncomment them at the bottom of
`lua/plugins/init.lua` to try them.

---

## Cheat sheet

```
FIND                          CODE                          GIT
Space Space  buffers          grd   definition              ]c [c      next/prev hunk
Space s f    files            grr   references              Space h p  preview hunk
Space s g    grep project     gri   implementation          Space h s  stage hunk
Space s w    grep word        grt   type definition         Space h r  reset hunk
Space /      search buffer    grn   rename                  Space h b  blame line
Space s .    recent files     gra   code action             Space g g  Neogit status
Space s r    resume search    K     hover docs              Space g d  diff all changes
Space s h    help             gO    file symbols            Space g h  file history
Space s k    keymaps          gW    project symbols         Space g q  close diffview
                              Space f  format
FILES                         Space t h  inlay hints        RUST
-            oil explorer                                   Space r r  run
Space a      harpoon add      DIAGNOSTICS                   Space r t  test
Space e      harpoon menu     ]d [d      next/prev          Space r e  expand macro
Space 1..4   harpoon jump     Ctrl-w d   show float         Space c v  crate versions
                              Space x x  Trouble: all       Space c u  update crate
EDIT                          Space x X  Trouble: buffer
saiw)   surround word         Space x s  symbols outline    COMPLETION (insert)
sd"     delete surround       Space q    loclist            Ctrl-y      accept
sr)]    replace surround                                    Ctrl-Space  open / docs
ciq     change in quotes      WINDOWS                       Ctrl-e      close
cif     change in func call   Ctrl-h/j/k/l  move            Tab         next snippet field
gcc     comment line          Esc Esc       leave terminal
v an    grow selection        Space t m     markdown render
```

Happy hacking. And remember: when in doubt, press `Space` and wait.
