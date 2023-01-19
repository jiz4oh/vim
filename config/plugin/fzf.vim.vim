function! FzfGrepMap(lhs, cmd)
  "nnoremap <silent> <leader>sp :Pg<Cr>
  execute 'nnoremap ' . a:lhs.' :' . a:cmd . '<CR>'

  "vnoremap <silent> <leader>sp :<C-u>execute ':Pg '.personal#functions#selected()<CR>
  execute "vnoremap <silent> " . a:lhs . " :<C-u>execute ':" . a:cmd . " '.personal#functions#selected()<CR>"
endfunction

let g:fzf_default_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

command! -nargs=? -bang Compilers call fzf#customized#compilers()
command! -nargs=? -bang Path      call fzf#customized#path(<q-args>, <bang>0)
command! -nargs=? -bang Sessions  call fzf#customized#sessions(<bang>0)

command! -nargs=? -bang RG        call fzf#customized#rg(<q-args>, <bang>0)
command! -nargs=? -bang Pg        call fzf#customized#grep(personal#project#find_home(), <q-args>, <bang>0)
command! -nargs=? -bang Wg        call fzf#customized#grep(getcwd(), <q-args>, <bang>0)
command! -nargs=? -bang GitGrep   call fzf#customized#grep(personal#git#Repo(), <q-args>, <bang>0)
command! -nargs=? -bang GGrep     call fzf#customized#grep(personal#git#Repo(), <q-args>, <bang>0)
command! -nargs=* -bang Tags      call fzf#vim#tags(expand('<cword>') . ' ', fzf#vim#with_preview({ 'dir': systemlist('git rev-parse --show-toplevel 2>/dev/null || pwd')[0], "placeholder": "--tag {2}:{-1}:{3..}", 'options': '--exact --select-1 --exit-0 +i'}), <bang>0)
command! -bar -bang Imaps call fzf#vim#maps("i", <bang>0)
command! -bar -bang Xmaps call fzf#vim#maps("x", <bang>0)
command! -bar -bang Omaps call fzf#vim#maps("o", <bang>0)

nmap <M-Tab> <plug>(fzf-maps-n)
imap <M-Tab> <plug>(fzf-maps-i)
xmap <M-Tab> <plug>(fzf-maps-x)

" fzf
imap <c-x><c-k> <plug>(fzf-complete-word)
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --follow
  set grepformat=%f:%l:%c:%m
  let $FZF_DEFAULT_COMMAND='rg --files --hidden -g "!{.git}/*" 2>/dev/null'

  let g:_fzf_ignore = []
  " https://github.com/junegunn/fzf.vim/issues/133#issuecomment-225541566
  function! FzfWithWildignore(args)
    let rgignore = '/tmp/rgignore-for-fzf'
    let entries = split(&wildignore, ',')
    if g:_fzf_ignore != entries
      call writefile(entries, rgignore)
      let g:_fzf_ignore = entries
    endif
    let source = 'rg --no-ignore-vcs --ignore-file ' . rgignore .' --column --line-number --no-heading --smart-case --follow --color=always ' . a:args . ' || true'
    return source
  endfunction

  inoremap <expr> <c-x><c-f> fzf#vim#complete#path($FZF_DEFAULT_COMMAND)
  inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))
else
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-l> <plug>(fzf-complete-line)
endif

call FzfGrepMap('<leader>s<Space>', 'RG')
call FzfGrepMap('<leader>ss', 'Sessions')
call FzfGrepMap('<leader>sl', 'Path')
call FzfGrepMap('<leader>sp', 'Pg')
call FzfGrepMap('<leader>sw', 'Wg')

nnoremap <leader>st :Tags<cr>
nnoremap <leader>sb :BLines<cr>
nnoremap <leader>sm :Marks<cr>
nnoremap <leader>s: :History:<cr>
nnoremap <leader>s/ :History/<cr>
nnoremap <C-]>      :Tags<cr>

augroup update_bat_theme
  autocmd!

  autocmd VimEnter,colorscheme * if &background == 'dark' | let $BAT_THEME='OneHalfDark' | else | let $BAT_THEME='' | endif
augroup end
