let g:startify_change_to_dir              = 0
let g:startify_relative_path              = 1
let g:startify_files_number               = 5
let g:startify_session_delete_buffers     = 1
let g:startify_session_persistence        = 1
let g:startify_session_before_save = [
    \ 'echo "Cleaning up before saving.."',
    \ 'silent! NERDTreeTabsClose'
    \ ]

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
let g:startify_lists = [
        \ { 'type': 'sessions',                        'header': ['   Sessions']     },
        \ { 'type': 'bookmarks',                       'header': ['   Bookmarks']    },
        \ { 'type': function('personal#git#Modified'), 'header': ['   Git Modified'] },
        \ { 'type': function('personal#git#Untracked'),'header': ['   Git Untracked']},
        \ { 'type': function('personal#git#Staged'),   'header': ['   Git Staged']   },
        \ { 'type': 'dir',                             'header': ['   MRU '.getcwd()]},
        \ { 'type': 'files',                           'header': ['   MRU']          },
        \ { 'type': 'commands',                        'header': ['   Commands']     },
        \ ]

let g:startify_bookmarks = [
            \ g:wiki_root . '/drafts/todo.md',
            \ g:wiki_root . '/drafts/quicknote.md',
            \ '~/.vimrc',
            \ '~/.vim/vimrc.bundles',
            \ '~/.zshrc',
            \ ]

let g:startify_commands = [
    \ {'w': ['笔记列表', 'WikiIndex']},
    \ {'p': ['搜索项目', 'Pg']},
    \ {'c': ['查看提交', 'Commits']},
    \ {'u': ['插件更新', 'PlugUpdate']},
    \ {'i': ['插件安装', 'PlugInstall']},
    \ ]
