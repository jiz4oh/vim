let g:config_src = 'https://github.com/jiz4oh/vim.git'
let g:config_dir = resolve(expand('<sfile>:p:h'))

let g:wiki_root               = $HOME . '/Documents/wiki'
let g:rails_vim_enter         = 0

if has('nvim')
  let session_dir = has('nvim-0.3.1')
        \ ? stdpath('data').'/session'
        \ : has('win32')
        \   ? '~/AppData/Local/nvim-data/session'
        \   : '~/.local/share/nvim/session'
else " Vim
  let session_dir = has('win32')
        \ ? '~/vimfiles/session'
        \ : '~/.vim/session'
endif

let g:session_dir          = session_dir
let g:startify_session_dir = g:session_dir

let g:startify_bookmarks = [
            \ $MYVIMRC,
            \ g:config_dir,
            \ g:wiki_root,
            \ ]

let g:startify_commands = get(g:, 'startify_commands', {})

let markers = [
      \'.git', '.hg', '.svn', '.bzr', '_darcs', '_FOSSIL_',
      \'.fslckout', 'package.json', 'Gemfile', '.projections.json'
      \]


let g:projectionist_heuristics = {
      \ ".git/|.hg/|.svn/|.bzr/|package.json|Gemfile": {
      \   },
      \ }

let g:gutentags_project_root = markers
let g:rooter_patterns        = markers
