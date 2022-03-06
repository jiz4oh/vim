" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://cdn.jsdelivr.net/gh/junegunn/vim-plug@master/plug.vim
endif

set updatetime=100
"Run PlugInstall if there are missing plugins
"autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  "\| PlugInstall --sync | source $MYVIMRC
"\| endif

call plug#begin('~/.vim/bundle')
"==================== https://github.com/jiz4oh/vim#跳转 ====================
Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }

" https://github.com/easymotion/vim-easymotion
Plug 'easymotion/vim-easymotion', {'on':
   \ [
   \ '<Plug>(easymotion-bd-f)', '<Plug>(easymotion-overwin-f)',
   \ '<Plug>(easymotion-bd-jk)', '<Plug>(easymotion-overwin-line)',
   \ ]}

"==================== https://github.com/jiz4oh/vim#搜索 ====================
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } |
     \ Plug 'junegunn/fzf.vim'

"==================== https://github.com/jiz4oh/vim#项目结构 ================
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-rooter'
"==================== https://github.com/jiz4oh/vim#文件浏览器 ==============
Plug 'preservim/nerdtree' |
      \ Plug 'Xuyuanp/nerdtree-git-plugin'

"==================== https://github.com/jiz4oh/vim#补全 ====================
if has('nvim')
  "lsp
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
  "autocomplte
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'quangnguyen30192/cmp-nvim-tags'
  if executable('rg')
    Plug 'lukas-reineke/cmp-rg'
  end
  Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
  "fzf integration
  "https://github.com/ojroques/nvim-lspfuzzy
  Plug 'ojroques/nvim-lspfuzzy'
endif

"==================== https://github.com/jiz4oh/vim#rails ===================
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-dispatch'

"==================== https://github.com/jiz4oh/vim#文档 ====================
Plug 'mzlogin/vim-markdown-toc'

" markdown preview
if has('nvim')
  Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' }
endif

Plug 'lervag/wiki.vim'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'junegunn/goyo.vim', { 'on': 'Goyo', 'for': 'markdown' }
"==================== https://github.com/jiz4oh/vim#其他 ====================
Plug 'vlime/vlime', {'rtp': 'vim/'}
Plug 'kovisoft/paredit', { 'for': ['clojure', 'scheme'] }

Plug 'ludovicchabant/vim-gutentags'
Plug 'sheerun/vim-polyglot'
Plug 'asins/vim-dict'
Plug 'tpope/vim-rsi'

Plug 'mhinz/vim-startify'
Plug 'dstein64/vim-startuptime', {'on':'StartupTime'}
if has('nvim')
  Plug 'nathom/filetype.nvim'
endif

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'svermeulen/vim-cutlass'
"==================== https://github.com/jiz4oh/vim#美化 ====================
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'ryanoasis/vim-devicons'
call plug#end()

colorscheme onehalfdark
