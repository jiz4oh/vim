# Jiz4oh's vim configuration

fork from the [wklken/k-vim](https://github.com/wklken/k-vim), with some configuration changes according to my personal preferences

The Server-Edition does not contain additional plugins, it is mainly used on the server and is intended to be used as a simple text editor

The IDE-Edition is based on the server version with the addition of common development plugins and some additional settings, and is intended to be used as an IDE

## Install

### IDE-Edition

`curl https://raw.githubusercontent.com/jiz4oh/vim/master/install.sh | bash`

中国区用户可以使用 jsdelivr 来过墙：

`curl https://cdn.jsdelivr.net/gh/jiz4oh/vim@master/install.sh | bash`

### Server-Edition

`curl https://raw.githubusercontent.com/jiz4oh/vim/master/vimrc > ~/.vimrc`

中国区用户可以使用 jsdelivr 来过墙：

`curl https://cdn.jsdelivr.net/gh/jiz4oh/vim@master/vimrc > ~/.vimrc`

## Features:

### Server-Edition

- 2 spaces, no tabs
- incremental, case-insensitive search
- vertical split goes right, horizontal split goes below
- easier indentation of selected items
- `<C-a/e>` switch line beginning and end
- `<C-j/k/h/l>`  switch between splits (no need to prepend <C-w>)
- ` sa` select all
- `U` redo
- ` /` remove highlight

#### File Switching

- `<space>cd` switch work directory to directory of current file
- `<space><tab>` alternates between two most recent buffers 

#### Terminal

- `<space>t` open terminal in a new split window
- `<space>vt` open terminal in a new vertical split window
- `<C-W><Esc>` quit to normal mode

#### Motion

- `[e` move up current line
- `]e` move down current line

### IDE-Edition

- all features of Sesrver-Edition
- `<space>cc` comment current line
- `<space>cu` uncomment current line

#### Motion

NOTE: two spaces

- `<space><space>h` move to current line forward 
- `<space><space>j` move to line downward
- `<space><space>k` move to line upward
- `<space><space>l` move to current line backward
- `<space><space>w` move to word downward
- `<space><space>b` move to word upward
- `s` move to word 

#### Search

- `<space>f` search filename at current work directory
- `<space>b` search filename at current buffer files
- `<space>h` search filename at opened file history 
- `<space>l` search word/filename at buffer files
- `<space>bl` search word/filename at current buffer file
- `<space>r` search word/filename at current work directory
- `<C-B>` search current/selected word at current work directory

## Inspire

- [vim-for-server](https://github.com/wklken/vim-for-server)
- [Vim-plug](https://github.com/junegunn/vim-plug)

