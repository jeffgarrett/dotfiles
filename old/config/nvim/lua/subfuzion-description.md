## Key map features

I try to avoid C-<key> combinations for the things I do frequently, mapping things that make sense to the `<leader>` key. The
[leader key](http://usevim.com/2012/07/20/vim101-leader/) provides a facility for creating customized shortcuts that can be further restricted to apply only in certain modes, such as normal, insert, visual, terminal (neovim-specific), etc.

The leader key is normally defined by the `mapleader` variable as `\`. Many people like to redefine it to `,`. I prefer
`;` since it sits right under my right pinkie.

### Leader key

`;`

In the section below, you can substitute `;` for whatever you have configured for you `<leader>` key.

### Insert mode

| Shortcut | Action |
| -------- | ------ |
| `;;`     | Escape (exit insert mode)

### Normal mode

| Shortcut | Action |
| -------- | ------ |
| `;c`     | Toggle light and dark themes
| `;h`     | Toggle distraction free mode (hide/show both nerdtree and tagbar)
| `Space`  | Toggle [NERD Tree](https://github.com/scrooloose/nerdtree), a file tree explorer.
| `;tb`    | Toggle tagbar
| `C-l`    | Redraw and ald also clear current highlighted search items (note: `l' is lowercase `L`, not number `1`)
| `C-p`    | Open fuzzy finder (for files, buffers, etc)


| Shortcut | Action |
| -------- | ------ |
| `;ec`    | Edit vim/neovim config
| `;sc`    | Source (reload) the config (save it first with `:w`)
|
| `;n`     | Toggle line numbers
| `;w`     | Toggle wrap
|
| `bv`     | Create a new (empty) buffer to the right of a vertical split
| `bh`     | Create a new (empty) buffer below a horizontal split
| `;bb`    | Toggle between current and last buffer
| `;bn`    | Go to next buffer
| `;bp`    | Go tp prev buffer
| `;bd`    | Delete current buffer
| `;bk`    | Kill current buffer (don't prompt to save changes)
| `;bl`    | List buffers
| `;bg`    | List and select buffer by #
|
| `;tt`    | Open a full screen terminal
| `;tv`    | Open a terminal in a new split to the right
| `;th`    | Open a terminal in a new split below
|
| `;c`     | Toggle between light and dark backround modes (for supported themes)

#### Go support

| Shortcut | Action |
| -------- | ------ |
| `gd`     | go-def
| `;gd`     | go-doc
| `;gv`     | go-doc in a new vertical split to the right
| `;gb`     | go-doc for current word in a new browser window/tab
| `;gs`     | go-implements
| `gi`     | go-info

To learn more or customize yourself, see [fatih/vim-go](https://github.com/fatih/vim-go) and read [this](http://hackersome.com/p/fatih/vim-go).

### Terminal mode

| Shortcut | Action |
| -------- | ------ |
| `C-x`    | Quit terminal buffer

### Any mode

| Shortcut | Action |
| -------- | ------ |
| `A-h`    | Go to buffer to the left
| `A-j`    | Go to buffer below
| `A-k`    | Go to buffer above
| `A-l`    | go to buffer to the right


