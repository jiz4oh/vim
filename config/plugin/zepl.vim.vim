let g:repl_config = {
            \   'javascript': { 'cmd': 'node' },
            \   'ruby': { 'cmd': 'irb'},
            \   'vim': { 'cmd': 'vim -E'},
            \ }

" https://github.com/tpope/vim-dispatch/blob/00e77d90452e3c710014b26dc61ea919bc895e92/autoload/dispatch.vim#L433
function! s:extract_opts(command, ...) abort
  let command = a:command
  let opts = {}
  while command =~# '^\%(-\|++\)\%(\w\+\)\%([= ]\|$\)'
    let opt = matchstr(command, '\zs\w\+')
    if command =~# '^\%(-\|++\)\w\+='
      let val = matchstr(command, '\w\+=\zs\%(\\.\|\S\)*')
    else
      let val = 1
    endif
    if opt ==# 'dir' || opt ==# 'directory'
      let opts.directory = fnamemodify(expand(val), ':p:s?[^:]\zs[\\/]$??')
    elseif index(['compiler', 'title', 'wait'], opt) >= 0
      let opts[opt] = substitute(val, '\\\(\s\)', '\1', 'g')
    endif
    let command = substitute(command, '^\%(-\|++\)\w\+\%(=\%(\\.\|\S\)*\)\=\s*', '', '')
  endwhile
  return [command, extend(opts, a:0 ? a:1 : {})]
endfunction

function! s:cmd() abort
  let cmd = ''
  if !empty(get(b:, 'start', ''))
    let [cmd, opts] = s:extract_opts(b:start)
  end
  return cmd
endfunction

nnoremap <silent> <leader>rr :execute 'botright 16 Repl ' . <SID>cmd()<cr>
nnoremap <silent> <leader>rk :execute 'botright keep 16 Repl ' . <SID>cmd()<cr>

if has('nvim')
  runtime zepl/contrib/nvim_autoscroll_hack.vim
endif

xnoremap '<CR> :<C-u>execute 'botright keep 16 Repl ' . <SID>cmd()<cr>gv:ReplSend<cr>
