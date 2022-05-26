" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://cdn.jsdelivr.net/gh/junegunn/vim-plug@master/plug.vim
endif

"Run PlugInstall if there are missing plugins
"autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  "\| PlugInstall --sync | source $MYVIMRC
"\| endif

silent! if plug#begin('~/.vim/bundle')
set updatetime=100

"==================== https://github.com/jiz4oh/vim#跳转 ====================
if has("patch-7.3-1058") && executable('ctags')
  Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }
endif

" https://github.com/easymotion/vim-easymotion
Plug 'easymotion/vim-easymotion'

"==================== https://github.com/jiz4oh/vim#搜索 ====================
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } |
     \ Plug 'junegunn/fzf.vim'

"==================== https://github.com/jiz4oh/vim#项目结构 ================
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
if v:version >= 800
  Plug 'rhysd/git-messenger.vim'
endif
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
  if executable('ctags')
    Plug 'quangnguyen30192/cmp-nvim-tags'
  endif
  Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
  "fzf integration
  "https://github.com/ojroques/nvim-lspfuzzy
  Plug 'ojroques/nvim-lspfuzzy'
elseif v:version >= 800
  "lsp
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  "autocomplete
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-buffer.vim'
  Plug 'prabirshrestha/asyncomplete-file.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  if executable('ctags')
    Plug 'prabirshrestha/asyncomplete-tags.vim'
  endif
endif

"==================== https://github.com/jiz4oh/vim#rails ===================
Plug 'vim-ruby/vim-ruby'
if executable('bundle')
  Plug 'tpope/vim-bundler'
endif
Plug 'tpope/vim-rails'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-rbenv'

"==================== https://github.com/jiz4oh/vim#文档 ====================
Plug 'lervag/wiki.vim'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

if v:version >= 704
  Plug 'mzlogin/vim-markdown-toc', { 'on': ['GenTocGFM', 'UpdateToc'] }
endif

" markdown preview
if v:version >= 800
  Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()' }
endif
Plug 'ferrine/md-img-paste.vim', { 'for': 'markdown' }
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
"==================== https://github.com/jiz4oh/vim#其他 ====================
" Plug 'vlime/vlime', {'rtp': 'vim/'}
" Plug 'kovisoft/paredit', { 'for': ['clojure', 'scheme'] }
if has('nvim') || has('patch-8.0-1453')
  Plug 'fatih/vim-go', { 'for': 'go' }
endif

if executable('ctags')
  Plug 'ludovicchabant/vim-gutentags'
endif
Plug 'asins/vim-dict'
Plug 'tpope/vim-rsi'

Plug 'justinmk/vim-gtfo'
Plug 'mhinz/vim-startify'
Plug 'dstein64/vim-startuptime', {'on':'StartupTime'}
if has('nvim')
  Plug 'nathom/filetype.nvim'
endif

Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
Plug 'junegunn/vim-peekaboo'
" Plug 'AndrewRadev/splitjoin.vim'
"==================== https://github.com/jiz4oh/vim#美化 ====================
" if has('nvim')
"   Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
" endif
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'ryanoasis/vim-devicons'
call plug#end()
endif

silent! colorscheme base16-gruvbox-dark-soft
