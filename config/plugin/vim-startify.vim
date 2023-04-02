if exists('g:session_dir')
  let g:startify_session_dir          = g:session_dir
endif

let g:startify_skiplist               = ['^/mnt/nfs']
let g:startify_change_to_dir          = 1
let g:startify_relative_path          = 1
let g:startify_files_number           = 10
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
    \ 'MRU_Exclude_Files',
    \ ]

let g:startify_bookmarks = [
            \ $MYVIMRC,
            \ ]

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
let g:startify_lists = [
        \ { 'type': function('MRUCwd', [g:startify_files_number]),     'header': ['   MRU']                     },
        \ { 'type': 'sessions',                                        'header': ['   Sessions']                },
        \ { 'type': 'bookmarks',                                       'header': ['   Bookmarks']               },
        \ { 'type': 'commands',                                        'header': ['   Commands']                },
        \ ]

let g:startify_commands = [
    \ {'d': ['Databases',       'enew | DBUI']      },
    \ {'u': ['Update Plugins',  'PlugUpdate']  },
    \ {'i': ['Install Plugins', 'PlugInstall'] },
    \ ]

function! LoadSessionFromFzf(name) abort
  execute 'SLoad ' . a:name
endfunction

function! GetSessions() abort
  if !isdirectory(g:session_dir)
    call mkdir(fnamemodify(g:session_dir, ':p'), 'p')
  endif

  return filter(systemlist('ls ' . g:session_dir), 'v:val !=? "__LAST__"')
endfunction

function! SaveSession() abort
  if empty(v:this_session) && index(['startify'], &filetype) < 0
    SSave! default
  end
  SClose
endfunction

nnoremap <silent> <leader><tab> :call SaveSession()<cr>
