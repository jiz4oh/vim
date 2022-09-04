let g:config_src = 'https://github.com/jiz4oh/vim.git'
let g:config_dir = resolve(expand('<sfile>:p:h'))

let g:wiki_root               = $HOME . '/Documents/wiki'
let g:rails_vim_enter         = 0

let g:startify_bookmarks = [
            \ $MYVIMRC,
            \ g:config_dir,
            \ g:wiki_root,
            \ ]

let g:startify_commands = get(g:, 'startify_commands', {})
