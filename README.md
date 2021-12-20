# Jiz4oh's vim configuration

从 [wklken/k-vim](https://github.com/wklken/k-vim) 开始，随着自己使用的增加
而添加了一些自己用着舒服的配置。

服务器版不包含插件安装，只是一个基础 vimrc 文件，方便在服务器上使用常用的快捷键。

IDE 版是尝试将 vim/neovim 作为一个正式的开发环境而配置，包含我对比之后认为
比较好用的插件。宗旨是尽量使用 vimscript 插件和 lua 插件，减少外部依赖，比如
YouCompleteMe 这种非常难以安装的插件。

## 依赖与安装

### 服务器版

`curl https://raw.githubusercontent.com/jiz4oh/vim/master/vimrc > ~/.vimrc`

中国区用户可以使用 jsdelivr 来过墙：

`curl https://cdn.jsdelivr.net/gh/jiz4oh/vim@master/vimrc > ~/.vimrc`

### IDE 版

`curl https://raw.githubusercontent.com/jiz4oh/vim/master/install.sh | bash`

中国区用户可以使用 jsdelivr 来过墙：

`curl https://cdn.jsdelivr.net/gh/jiz4oh/vim@master/install.sh | bash`

#### 依赖

1. [`fzf`](https://github.com/junegunn/fzf)  
   在启用 IDE 版之后，会自动调用 fzf#install()
2. [`ripgrep`](https://github.com/BurntSushi/ripgrep)  
   可选, [安装教程](https://github.com/BurntSushi/ripgrep#installation)
3. [`neovim`](https://github.com/neovim/neovim)  
   可选，至少需要 neovim 0.5+，如果不需要补全可以只使用 vim

## 功能:

### 服务器版

- 增量且大小写不敏感的搜索
- 新增窗口时总是在右边/下边
- 更轻松的缩进
- 使用 2 个空格代替制表符
- utf-8 优先
- 状态栏左侧显示当前文件，右侧显示当前行/列数

快捷键|应用模式|描述
---|---|---
f2|n|切换显示行号
f3|n|切换显示不可见字符
f4|n|当行超框时是否换行显示
f6|n|启用/禁用语法高亮
q|n|退出当前窗口，在最后一个窗口时不生效
`<space>/`|n|移除搜索高亮
`U`|n|重做     
`Y`|n|从光标处复制到行尾
`<space>sa`|n|全选整个文件
`ctrl-h/j/k/l`|n|分别移动光标到当前窗口的左/下/上/右侧窗口
`ctrl-a/e`|n|分别移动光标到当前行首/尾
`>>` / `<<`|n|缩进/反向缩进
`>` / `<`|v|缩进/反向缩进
`alt-l` / `alt-h`|n/v/i|缩进/反向缩进
`[e` / `]e`|n/v|向上/下移动当前行
`alt-k` / `alt-j`|n/v/i|向上/下移动当前行
`<space>cd>`|n|将当前 buffer 所在目录作为工作目录
`<space><tab>`|n|切换到上一个 buffer
`<space>tt` / `<space>tv`|n|在下/右方打开终端
`<C-W><Esc>`|t|在终端中进入 normal 模式
`<leader>ee`|n|打开文件管理器 netrw

### IDE 版

- 包含所有服务器版的功能，在对某些功能使用插件扩展的同时尽量保持一致，比如使用
NERDTree 代替 netrw

#### 搜索

插件：

- https://github.com/junegunn/fzf
- https://github.com/junegunn/fzf.vim

快捷键|速记|应用模式|描述
---|---|---|---
`<space>sb`|search buffer|n|在当前 buffer 搜索
`<space>swb`|search word in buffer|n/v|在当前 buffer 搜索当前单词/选中内容
`<space>sp`|search project|n|在git仓库搜索文件名/内容，如果不处于git仓库下则搜索当前工作目录
`<space>swp`|search word in project|n/v|在git仓库搜索当前单词/选中内容，如果不处于git仓库下则搜索当前工作目录
`<space>sd`|search dir|n|在当前工作目录下搜索文件名
`<space>sh`|search history|n|在 fzf 历史记录中搜索文件名
`<space>sg`|search gem|n|跳转到指定 gem 中搜索文件内容(需要 bundle)
`<space>swg`|search word in gem|n|跳转到指定 gem 中搜索当前单词/选中内容(需要 bundle)
ctrl-x/v||fzf|在下/右方打开文件
ctrl-t||fzf|在新 tab 中打开文件
ctrl-f/b||fzf|搜索结果下/上一页
alt-f/b||fzf|预览窗口下/上一页

命令|速记|描述
---|---|---
Pg|Project Prep|在git仓库搜索文件名/内容，如果不处于git仓库下则搜索当前工作目录
Rg|RipGrep|在当前工作目录下搜索文件内容
GGrep/GitGrep||在 git 仓库搜索文件名/内容
Gems||跳转到指定 gem 中搜索文件内容(需要 bundle)

#### 跳转

插件：

- https://github.com/easymotion/vim-easymotion

快捷键|速记|应用模式|描述
---|---|---|---
`f`|find|n|通过输入一个字符跳转到指定单词
`gl`|go to line|n|跳转到某行

#### 文件浏览器

插件：

- https://github.com/preservim/nerdtree
- https://github.com/Xuyuanp/nerdtree-git-plugin

快捷键|速记|应用模式|描述
---|---|---|---
`<space>ee`|explore|n|打开浏览器并定位到当前文件
`<space>ep`|explore project|n|打开当前文件所在的 git repo 根目录
`j`/`k`||nerdtree|上下移动
`h`||nerdtree|进入上一个目录
`l`||nerdtree|打开/收起目录或者打开文件
`H`/`L`||nerdtree|递归收起/打开目录
`<backspace>`||nerdtree|回退到上一个目录并将工作目录切换为上一个目录
`<enter>`||nerdtree|进入目录并将切换工作目录或者打开文件

#### git

插件：

- https://github.com/airblade/vim-gitgutter
- https://github.com/tpope/vim-fugitive

快捷键|速记|应用模式|描述
---|---|---|---
`<space>gw`|git write|n|将当前文件加入暂存区
`<space>ga`|git add|n|将当前文件恢复到已提交版本
`<space>gc`|git commit|n|提交
`<space>gf`|git diff|n|对比当前文件与已提交版本
`<space>gl`|git log|n|查看提交日志
`<space>gs`|git status|n|查看当前仓库状态

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
`<Tab>`||i/s/c|切换到下一个补全选项
`shift-<Tab>`||i/s/c|切换到上一个补全选项
`ctrl-j`||i/s/c|切换到下一个补全选项
`ctrl-k`||i/s/c|切换到上一个补全选项
`<enter>`||i/s/c|使用当前选中选项进行补全
`K`||n|查看当前符号对应的文档
`ctrl-f`||n|向下移动文档
`ctrl-b`||n|向上移动文档
`gd`|go to definition|n|跳转到定义，如果有多个，激活 fzf 查询窗口
`gD`|go to declaration|n|跳转到声明，如果有多个，激活 fzf 查询窗口
`gr`|go to references|n|跳转到引用，如果有多个，激活 fzf 查询窗口
`gi`|go to implementation|n|跳转到实现，如果有多个，激活 fzf 查询窗口
`[d`|diagnostic|n|跳转到上一个语法错误
`]d`|diagnostic|n|跳转到下一个语法错误
`<space>f`|format|n|根据语法检查格式化当前 buffer

#### rails

插件：

- https://github.com/vim-ruby/vim-ruby
- https://github.com/tpope/vim-bundler
- https://github.com/tpope/vim-rails
- https://github.com/tpope/vim-dispatch

快捷键|速记|应用模式|描述
---|---|---|---
`gf`|go to file|n|跳转到 has_many,belongs_to 等关系对应的类

#### 其他

插件：

- https://github.com/preservim/nerdcommenter
- https://github.com/preservim/tagbar
- https://github.com/tpope/vim-endwise
- https://github.com/instant-markdown/vim-instant-markdown

快捷键|速记|应用模式|描述
---|---|---|---
`<space>cc` / `<space>cu`|comment/uncomment|n|注释/取消注释
`<space>m`||n|打开当前文件结构
`<space><space>i`|install|n|安装插件

## Inspire

- [Vim-plug](https://github.com/junegunn/vim-plug)
- [vim-for-server](https://github.com/wklken/vim-for-server)
- [Vime](https://github.com/fgheng/vime)

