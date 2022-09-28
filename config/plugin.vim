" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://cdn.jsdelivr.net/gh/junegunn/vim-plug@master/plug.vim
endif

"Run PlugInstall if there are missing plugins
"autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  "\| PlugInstall --sync | source $MYVIMRC
"\| endif

if exists(':packadd')
  silent! packadd! matchit
  if has("patch-8.1.0311")
    silent! packadd! cfilter
  endif
else
  runtime macros/matchit.vim
endif

silent! if plug#begin('~/.vim/bundle')
set updatetime=100
" ============================================================================
" NAVIGATION / MOVE / Easier READ {{{
" ============================================================================
Plug 'christoomey/vim-tmux-navigator'
" https://github.com/easymotion/vim-easymotion
Plug 'easymotion/vim-easymotion', { 'on': ['<Plug>(easymotion-prefix)', '<Plug>(easymotion-bd-jk)', '<Plug>(easymotion-overwin-line)'] }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } |
     \ Plug 'junegunn/fzf.vim'

Plug 'preservim/nerdtree', { 'on': ['NERDTree', 'NERDTreeVCS', 'NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'for': 'NERDTree' }
Plug 'PhilRunninger/nerdtree-visual-selection'
" }}}

" ============================================================================
" VCS / PROJECT {{{
" ============================================================================
Plug 'tpope/vim-projectionist'
Plug 'airblade/vim-rooter'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
" Plug 'junegunn/gv.vim', { 'on': ['GV', 'GV!'] }
Plug 'rbong/vim-flog', { 'on': ['Flog', 'Flogsplit'] }
" if v:version >= 800
"   Plug 'rhysd/git-messenger.vim'
" endif
" }}}

" ============================================================================
" DOCUMENT / MARKDOWN {{{
" ============================================================================
Plug 'lervag/wiki.vim'
" Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

if v:version >= 704
  Plug 'mzlogin/vim-markdown-toc', { 'on': ['GenTocGFM', 'UpdateToc'] }
endif

" markdown preview
if v:version >= 800
  Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()' }
endif
Plug 'ferrine/md-img-paste.vim', { 'for': 'markdown' }
" }}}

" ============================================================================
" DATABASE {{{
" ============================================================================
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'
" }}}
"
" ============================================================================
" REPL / BUILD / COMPILE {{{
" ============================================================================
Plug 'axvr/zepl.vim'
Plug 'tpope/vim-dispatch'
" }}}

" ============================================================================
" FILETYPE {{{
" ============================================================================
if has('nvim')
  Plug 'nathom/filetype.nvim'
endif
Plug 'hallison/vim-rdoc'
Plug 'vim-ruby/vim-ruby'
if executable('bundle')
  Plug 'tpope/vim-bundler'
endif
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv'
Plug 'towolf/vim-helm'
Plug 'kchmck/vim-coffee-script'
Plug 'chrisbra/csv.vim'
" Plug 'vlime/vlime', {'rtp': 'vim/'}
" Plug 'kovisoft/paredit', { 'for': ['clojure', 'scheme'] }
if has('nvim') || has('patch-8.0.1453')
  Plug 'fatih/vim-go', { 'for': 'go' }
endif
" }}}

" ============================================================================
" TEXT OBJECTS {{{
" ============================================================================
Plug 'michaeljsmith/vim-indent-object'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }
Plug 'adriaanzon/vim-textobj-matchit'
Plug 'rhysd/vim-textobj-anyblock'
Plug 'whatyouhide/vim-textobj-erb', { 'for': 'eruby' }
" }}}

" ============================================================================
" TAGS {{{
" ============================================================================
if executable('ctags')
  Plug 'ludovicchabant/vim-gutentags'
  if has("patch-7.3.1058")
    Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }
  endif
endif
"}}}

" ============================================================================
" Easier EDIT {{{
" ============================================================================
Plug 'dense-analysis/ale'

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
  " autocomplete
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-buffer.vim'
  Plug 'prabirshrestha/asyncomplete-file.vim'

  if executable('ctags')
    Plug 'prabirshrestha/asyncomplete-tags.vim'
  endif

  Plug 'machakann/asyncomplete-ezfilter.vim'
  if has('win32') || has('win64')
    Plug 'kitagry/asyncomplete-tabnine.vim', { 'do': 'powershell.exe .\install.ps1' }
  else
    Plug 'kitagry/asyncomplete-tabnine.vim', { 'do': './install.sh' }
  endif
  " deprcated lsp due to too slow with large text
  " " lsp
  " Plug 'prabirshrestha/vim-lsp'
  " Plug 'rhysd/vim-lsp-ale'
  " Plug 'mattn/vim-lsp-settings'
endif

Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
" Plug 'AndrewRadev/splitjoin.vim'
" }}}

" ============================================================================
" Utils {{{
" ============================================================================
if !has('gui_running')
  Plug 'vim-scripts/LargeFile'
endif
Plug 'liuchengxu/vim-which-key'
Plug 'ojroques/vim-oscyank'
Plug 'skywind3000/vim-dict'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'justinmk/vim-gtfo'
Plug 'mhinz/vim-startify'
Plug 'dstein64/vim-startuptime', {'on':'StartupTime'}

Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-apathy'
Plug 'AndrewRadev/undoquit.vim'
Plug 'kristijanhusak/vim-carbon-now-sh'
" }}}

" ============================================================================
" Butil-in Enhance {{{
" ============================================================================
" Plug 'andymass/vim-matchup'
Plug 'vim-utils/vim-man'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'tpope/vim-repeat'
if exists('##TextYankPost')
  Plug 'machakann/vim-highlightedyank'
end
Plug 'markonm/traces.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'haya14busa/vim-asterisk', { 'on': ['<Plug>(asterisk-z*)', '<Plug>(asterisk-z#)', '<Plug>(asterisk-gz*)', '<Plug>(asterisk-gz#)'] }
Plug 'troydm/zoomwintab.vim'
" }}}

" ============================================================================
" BEAUTIFY {{{
" ============================================================================
if has('nvim')
  " Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
endif
if has('nvim') || has('gui_running')
  Plug 'vim-airline/vim-airline'
endif
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/everforest'
Plug 'sainnhe/edge'
Plug 'ryanoasis/vim-devicons'
Plug 'uguu-org/vim-matrix-screensaver'
Plug 'vim/killersheep'
"}}}
call plug#end()
endif

silent! colorscheme gruvbox-material
