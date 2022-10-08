let g:is_darwin         = has('mac')
let g:is_mac_gui        = has('gui_macvim') && has('gui_running')
let g:is_win            = has('win32') || has('win64')
" https://unix.stackexchange.com/a/78220
let g:has_linux_desktop = !empty($XDG_CURRENT_DESKTOP)

let g:config_src = 'https://github.com/jiz4oh/vim.git'
let g:config_dir = resolve(expand('<sfile>:p:h'))

let g:wiki_root               = $HOME . '/Documents/wiki'
let g:rails_vim_enter         = 0

" needs to be defined before vim-polyglot is loaded
let g:polyglot_disabled = ['sensible', 'autoindent']

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
      \ ".git/": {
      \   ".git/hooks/*": {"type": "githook"},
      \   ".github/workflows/*": {"type": "githubworkflow"}
      \ },
      \ ".hg/|.svn/|.bzr/|Makefile": {
      \ },
      \ "package.json": {
      \ },
      \ "Gemfile|Rakefile": {
      \ }}

let g:gutentags_project_root = markers
let g:rooter_patterns        = markers

let g:enable_nerd_font        = g:is_mac_gui || index(['iTerm.app'], $TERM_PROGRAM) >= 0
let g:enable_markdown_preview = g:is_win || g:is_darwin || g:has_linux_desktop
let g:enable_autocomplete     = g:is_win || g:is_darwin || g:has_linux_desktop
let g:enable_lsp              = g:is_win || g:is_darwin || g:has_linux_desktop

