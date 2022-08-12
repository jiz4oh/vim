let g:startify_skiplist               = ['^/mnt/nfs']
let g:startify_change_to_dir          = 1
let g:startify_relative_path          = 1
let g:startify_files_number           = 5
let g:startify_session_delete_buffers = 1
let g:startify_session_persistence    = 1
let g:startify_session_before_save    = [
    \ 'echo "Cleaning up before saving.."',
    \ 'silent! NERDTreeTabsClose'
    \ ]
let g:startify_session_remove_lines   = ['_loaded']            " let plugin load agian

let g:startify_session_savevars = [
    \ 'g:startify_session_savevars',
    \ 'g:startify_session_savecmds',
    \ 'g:startify_session_remove_lines',
    \ ]

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
let g:startify_lists = [
        \ { 'type': 'sessions',                        'header': ['   Sessions']     },
        \ { 'type': 'bookmarks',                       'header': ['   Bookmarks']    },
        \ { 'type': 'dir',                             'header': ['   MRU '.getcwd()]},
        \ { 'type': 'files',                           'header': ['   MRU']          },
        \ { 'type': 'commands',                        'header': ['   Commands']     },
        \ ]

let g:startify_bookmarks = [
            \ g:wiki_root . '/drafts/todo.md',
            \ g:wiki_root . '/drafts/quicknote.md',
            \ g:config_dir,
            \ $MYVIMRC,
            \ '~/.zshrc',
            \ ]

let g:startify_commands = [
    \ {'w': ['笔记列表', 'WikiIndex']},
    \ {'g': ['Git',      'Git']},
    \ {'p': ['搜索项目', 'Pg']},
    \ {'d': ['数据库',   'DBUI']},
    \ {'c': ['查看提交', 'GV']},
    \ {'u': ['插件更新', 'PlugUpdate']},
    \ {'i': ['插件安装', 'PlugInstall']},
    \ ]

function! ToggleStartify()
  let l:buf_name = 'startify_buffer'
  if bufexists(l:buf_name)
      exec 'silent! bwipe ' . l:buf_name
  else
      exec 'bot vnew ' . l:buf_name
      Startify
      exec 'map <buffer> q :silent! bwipe ' . l:buf_name . '<CR>'
  endif
endfunction

map <F4> :call ToggleStartify()<CR>
