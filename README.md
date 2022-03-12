从 [wklken/k-vim](https://github.com/wklken/k-vim) 开始，随着自己使用的增加
而添加了一些自己用着舒服的配置。

服务器版不包含插件安装，只是一个基础 vimrc 文件，方便在服务器上使用常用的快捷键。

IDE 版是尝试将 vim/neovim 作为一个正式的开发环境而配置，包含我对比之后认为
比较好用的插件。宗旨是尽量使用 vimscript 插件和 lua 插件，减少外部依赖，比如
YouCompleteMe 这种非常难以安装的插件。

<!-- TOC GFM -->

* [依赖与安装](#依赖与安装)
   - [服务器版](#服务器版)
   - [IDE 版](#ide-版)
      + [依赖](#依赖)
* [功能:](#功能)
   - [服务器版](#服务器版-1)
   - [IDE 版](#ide-版-1)
      + [搜索](#搜索)
      + [跳转](#跳转)
      + [文件浏览器](#文件浏览器)
      + [项目结构](#项目结构)
      + [补全](#补全)
      + [rails](#rails)
      + [美化](#美化)
      + [文档](#文档)
* [Inspire](#inspire)
      + [其他](#其他)
* [Inspire](#inspire-1)

<!-- /TOC -->
## 依赖与安装

### 服务器版

`curl https://raw.githubusercontent.com/jiz4oh/vim/master/config/base.vim > ~/.vimrc`

### IDE 版

```console
git clone https://github.com/jiz4oh/vim.git vim
cd vim
touch ~/.vimrc && echo "source $PWD/init.vim" >> ~/.vimrc
touch ~/.config/nvim/init.vim && echo "source $PWD/init.vim" >> ~/.config/nvim/init.vim
```

#### 依赖

1. [fzf](https://github.com/junegunn/fzf)
   在启用 IDE 版之后，会自动调用 fzf#install()
2. [ripgrep](https://github.com/BurntSushi/ripgrep)
   可选, [安装教程](https://github.com/BurntSushi/ripgrep#installation)
3. [neovim](https://github.com/neovim/neovim)
   可选，至少需要 neovim 0.5+，如果不需要补全可以只使用 vim

## 功能:

### 服务器版

- 增量且大小写不敏感的搜索
- 新增窗口时总是在右边/下边
- 更轻松的缩进
- 使用 2 个空格代替制表符
- utf-8 优先
- 状态栏左侧显示当前文件，右侧显示当前行/列数
- 给插入模式添加常用的 emacs 快捷键
- 增加新的 text obj, <kbd>ie</kbd> / <kbd>iv</kbd>

快捷键|应用模式|描述
---|---|---
<kbd>F1</kbd>|n/i|打开文件管理器 netrw
<kbd>F2</kbd>|n/i|打开 quickfix list
<kbd>q</kbd>|n|退出当前窗口，在最后一个窗口时不生效
<kbd>\<space>/</kbd>|n|移除搜索高亮
<kbd>U</kbd>|n|重做
<kbd>Y</kbd>|n|从光标处复制到行尾
<kbd>ctrl-h</kbd> / <kbd>ctrl-j</kbd> / <kbd>ctrl-k</kbd> / <kbd>ctrl-l</kbd>|n|移动光标到当前窗口的左/下/上/右侧窗口
<kbd>ctrl-a</kbd> / <kbd>ctrl-e</kbd>|n/v/i/c|移动光标到当前行首/尾
<kbd>ctrl-f</kbd> / <kbd>ctrl-b</kbd>|i|光标向右/左移一位
<kbd>ctrl-u</kbd> / <kbd>ctrl-k</kbd>|i|从光标处删除直到行首/尾
<kbd>>></kbd> / <kbd><<</kbd>|n|缩进/反向缩进
<kbd>></kbd> / <kbd><</kbd>|v|缩进/反向缩进
<kbd>alt-l</kbd> / <kbd>alt-h</kbd>|n/v/i|缩进/反向缩进
<kbd>[e</kbd> / <kbd>]e</kbd>|n/v|向上/下移动当前行
<kbd>alt-k</kbd> / <kbd>alt-j</kbd>|n/v/i|向上/下移动当前行
<kbd>\<space>cd</kbd>|n|将当前 buffer 所在目录作为工作目录
<kbd>\<space><tab></kbd>|n|切换到上一个 buffer
<kbd>\<space>tt</kbd> / <kbd><space>tv</kbd>|n|在下/右方打开终端
<kbd>\<C-W><Esc></kbd>|t|在终端中进入 normal 模式
<kbd>\<operate>ie</kbd>|n|<操作>当前 buffer
<kbd>\<operate>iv</kbd>|n|<操作>当前 buffer 可视范围

### IDE 版

- 包含所有服务器版的功能，在对某些功能使用插件扩展的同时尽量保持一致，比如使用
NERDTree 代替 netrw

#### 搜索

插件：

- https://github.com/junegunn/fzf
- https://github.com/junegunn/fzf.vim

快捷键|速记|应用模式|描述
---|---|---|---
<kbd>\\</kbd>||v|在当前 buffer 向下搜索选中文本
<kbd>??</kbd>||v|在当前 buffer 向上搜索选中文本
<kbd>\<space>sb</kbd>|search buffer|n/v|使用 fzf 在当前 buffer 搜索
<kbd>\<space>sp</kbd>|search project|n/v|在git仓库搜索文件名/内容，如果不处于git仓库下则搜索当前工作目录
<kbd>\<space>st</kbd>|search tag|n|在 tags 中搜索，默认精准匹配
<kbd>\<space>sd</kbd>|search dir|n|在当前工作目录下搜索文件名
<kbd>\<space>sh</kbd>|search history|n|在 fzf 历史记录中搜索文件名
<kbd>\<space>sg</kbd>|search gem|n/v|在所有 gem 中搜索文件内容(需要 bundle)
<kbd>ctrl-x</kbd> / <kbd>ctrl-v</kbd>||fzf|在下/右方打开文件
<kbd>ctrl-t</kbd>||fzf|在新 tab 中打开文件
<kbd>ctrl-f</kbd> / <kbd>ctrl-b</kbd>||fzf|搜索结果下/上一页
<kbd>alt-f</kbd> / <kbd>ctrl-b</kbd>||fzf|预览窗口下/上一页

命令|速记|描述
---|---|---
`Pg`|Project Prep|在git仓库搜索文件名/内容，如果不处于git仓库下则搜索当前工作目录
`Rg`|RipGrep|在当前工作目录下搜索文件内容
`GGrep` / `GitGrep`||在 git 仓库搜索文件名/内容
`Gems`||在所有 gem 中搜索文件内容(需要 bundle)
`Gem`||跳转到指定 gem 中搜索文件内容(需要 bundle)

#### 跳转

插件：

- https://github.com/easymotion/vim-easymotion
- https://github.com/preservim/tagbar

快捷键|速记|应用模式|描述
---|---|---|---
<kbd>f</kbd>|find|n|通过输入一个字符跳转到指定单词
<kbd>gl</kbd>|go to line|n|跳转到某行
<kbd>F2</kbd>||n|打开当前文件结构

#### 文件浏览器

插件：

- https://github.com/preservim/nerdtree
- https://github.com/Xuyuanp/nerdtree-git-plugin

快捷键|速记|应用模式|描述
---|---|---|---
<kbd>F1</kbd>||n/i|打开文件浏览器并定位到当前文件
<kbd>ctrl-e</kbd>|explore|n/i|打开文件浏览器
<kbd>ctrl-v</kbd>||nerdtree|在水平窗口打开当前文件
<kbd>ctrl-x</kbd>||nerdtree|在垂直窗口打开当前文件
<kbd>j</kbd> / <kbd>k</kbd>||nerdtree|上下移动
<kbd>h</kbd>||nerdtree|进入上一个目录
<kbd>l</kbd>||nerdtree|打开/收起目录或者打开文件
<kbd>H</kbd> / <kbd>L</kbd>||nerdtree|递归收起/打开目录
<kbd>\<backspace></kbd>||nerdtree|回退到上一个目录并将工作目录切换为上一个目录
<kbd>\<enter></kbd>||nerdtree|进入目录并将切换工作目录或者打开文件

#### 项目结构

插件：

- https://github.com/airblade/vim-rooter
- https://github.com/airblade/vim-gitgutter
- https://github.com/tpope/vim-fugitive

快捷键|速记|应用模式|描述
---|---|---|---
<kbd>\<space>hs</kbd>|hunk stage|n|暂存 当前修改块(hunk) 的改动
<kbd>\<space>hp</kbd>|hunk preview|n|预览 当前修改块(hunk) 的改动
<kbd>\<space>hu</kbd>|hunk undo|n|还原 当前修改块(hunk) 的改动
<kbd>\<space>gf</kbd>|git diff|n|预览当前 buffer 的改动
<kbd>\<space>gr</kbd>|git read|n|还原当前 buffer 的所有改动
<kbd>\<space>gw</kbd>|git write|n|将当前文件加入暂存区
<kbd>\<space>gl</kbd>|git log|n|查看提交日志
<kbd>\<space>gs</kbd>|git status|n|查看当前仓库状态

#### 补全

插件：

- https://github.com/neovim/neovim
- https://github.com/neovim/nvim-lspconfig
- https://github.com/hrsh7th/nvim-cmp
- https://github.com/hrsh7th/cmp-nvim-lsp
- https://github.com/hrsh7th/cmp-buffer
- https://github.com/hrsh7th/cmp-path
- https://github.com/hrsh7th/cmp-cmdline
- https://github.com/ojroques/nvim-lspfuzzy

快捷键|速记|应用模式|描述
---|---|---|---
<kbd>ctrl-n</kbd>||i/c|切换到下一个补全选项
<kbd>ctrl-p</kbd>||i/c|切换到上一个补全选项
<kbd>ctrl-e</kbd>|||取消选中的补全选项
<kbd>\<enter></kbd>||i/s/c|使用当前选中选项进行补全
<kbd>K</kbd>||n|查看当前符号对应的文档
<kbd>ctrl-f</kbd>||n|向下移动文档
<kbd>ctrl-b</kbd>||n|向上移动文档
<kbd>gd</kbd>|go to definition|n|跳转到定义，如果有多个，激活 fzf 查询窗口
<kbd>gD</kbd>|go to declaration|n|跳转到声明，如果有多个，激活 fzf 查询窗口
<kbd>gr</kbd>|go to references|n|跳转到引用，如果有多个，激活 fzf 查询窗口
<kbd>gi</kbd>|go to implementation|n|跳转到实现，如果有多个，激活 fzf 查询窗口
<kbd>[d</kbd>|diagnostic|n|跳转到上一个语法错误
<kbd>]d</kbd>|diagnostic|n|跳转到下一个语法错误
<kbd>\<space>f</kbd>|format|n|根据语法检查格式化当前 buffer

#### rails

插件：

- https://github.com/tpope/vim-bundler
- https://github.com/tpope/vim-rails
- https://github.com/tpope/vim-dispatch

快捷键|速记|应用模式|描述
---|---|---|---
<kbd>gf</kbd>|go to file|n|跳转到 has_many,belongs_to 等关系对应的类

#### 美化

插件:

- https://github.com/ryanoasis/vim-devicons
- https://github.com/luochen1990/rainbow
- https://github.com/sonph/onehalf

#### 文档

插件:

- https://github.com/iamcco/markdown-preview.nvim
- https://github.com/lervag/wiki.vim
- https://github.com/mzlogin/vim-markdown-toc
- https://github.com/kkoomen/vim-doge
- https://github.com/junegunn/goyo.vim

快捷键|速记|应用模式|描述
---|---|---|---
<kbd>\<space>ww</kbd>||n|打开 wiki 索引页
<kbd>\<space>w<space>w</kbd>||n|打开今日日记
-<kbd>\<space>d</kbd>|document|n|为当前光标下的函数生成文档格式，并通过 <kbd>Tab</kbd> 切换到下一个文档

命令|速记|描述
---|---|---
`Goyo`||切换勿扰模式

## Inspire

- [Vim-plug](https://github.com/junegunn/vim-plug)
- [vim-for-server](https://github.com/wklken/vim-for-server)
- [Vime](https://github.com/fgheng/vime)

#### 其他

插件：

- https://github.com/sheerun/vim-polyglot
- https://github.com/tpope/vim-rsi
- https://github.com/tpope/vim-endwise
- https://github.com/tpope/vim-commentary
- https://github.com/svermeulen/vim-cutlass
   vim 原始的 c,s,d 会将删除内容保存在寄存器中，更类似于剪切功能。
   vim-cutlass 使 c,s,d 不再破坏寄存器，
   而我选择将 c 映射为原始的 d
- https://github.com/ludovicchabant/vim-gutentags
- https://github.com/justinmk/vim-gtfo
- https://github.com/AndrewRadev/splitjoin.vim

快捷键|速记|应用模式|描述
---|---|---|---
<kbd>gJ</kbd>|go to join|n|将多行代码缩写为一行
<kbd>gK</kbd>||n|将一行代码展开为多行
<kbd>gof</kbd>|go to file explore|n|使用文件管理器打开当前 buffer 所在目录
<kbd>got</kbd>|go to file explore|n|使用终端打开当前 buffer 所在目录
<kbd>cc</kbd>|cut|n|等于 dd
<kbd>c</kbd>|cut|n|等于 d
<kbd>gcc</kbd>|comment/uncomment|n|注释/取消注释
<kbd>gc</kbd>|comment|v|注释/取消注释
<kbd>\<space><space>i</kbd>|install|n|安装插件

## Inspire

- [Vim-plug](https://github.com/junegunn/vim-plug)
- [vim-for-server](https://github.com/wklken/vim-for-server)
- [Vime](https://github.com/fgheng/vime)

