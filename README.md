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

- incremental, case-insensitive search
- vertical split goes right, horizontal split goes below
- easier indentation of selected items

shortcut|mode|description
---|---|---
`<space>/`|n|remove highlight
`U`|n|undo
`Y`|n|copy to end of line
`<space>sa`|n|select all
`ctrl-h/j/k/l`|n|分别移动光标到当前窗口的左/下/上/右侧窗口
`ctrl-a/e`|n|分别移动光标到当前行首/尾
`>>` / `<<`|n|indent rightward/leftward
`>` / `<`|v|reselct after indent
`[e` / `]e`|n|move current line upward/downward
`<space>cd>`|n|switch work directory to directory of current file
`<space><tab>`|n|alternates between two most recent buffers 
`<space>tt` / `<space>tv`|n|open terminal in a split/vertical window
`<C-W><Esc>`|t|quit to normal mode

### IDE-Edition

- all features of Sesrver-Edition

shortcut|mode|description
---|---|---
`<space>cc` / `<space>cu`|n|comment/uncomment current line
`<space>j` / `<space>k`|n|move cursor downward/upward
`s`|n|move to specified word
`<space>sf`|n|search in buffer files
`<space>sp`|n|search current project(fallback to `$PWD` if no git repo)
`<space>sw`|n|like `<space>sp`,but with current/selected word
`<space>sd`|n|search in `PWD`
`<space>sh`|n|search in fzf history
`<space>sg`|n|search gem in bundle

#### Motion

shortcut|mode|description
---|---|---
`f`|n|move cursor by 1 char
`s`|n|move cursor by 2 char
`F`|n|move cursor to specified word
`gl`|n|move cursor to line

#### Search

shortcut|mode|description
---|---|---
`<space>sf`|n|search in buffer files
`<space>sp`|n|search current project(fallback to `$PWD` if no git repo)
`<space>sw`|n|like `<space>sp`,but with current/selected word
`<space>sd`|n|search in `PWD`
`<space>sh`|n|search in fzf history

#### File Explorer

use `nerdtree` if `coc.nvim` is not installed, otherwise use `coc-explorer`

shortcut|mode|description
---|---|---
`<space>ee`|n|open explorer
`<space>ep`|n|open explorer in the root directory of current project
`j`/`k`|n|next/prev
`h`|n|collapse
`l`|n|expand dir or open file
`H`/`L`|n|collapse/expand dir recursively
`<backspace>`|up to parent dir
`<enter>`|enter dir or open file

## Inspire

- [Vim-plug](https://github.com/junegunn/vim-plug)
- [vim-for-server](https://github.com/wklken/vim-for-server)
- [Vime](https://github.com/fgheng/vime)

