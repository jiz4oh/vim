if get(s:, 'loaded', 0) != 0
	finish
else
	let s:loaded = 1
endif

let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

command! -nargs=1 LoadVim exec 'source ' . s:home.'/' . '<args>'
command! -nargs=1 LoadLua exec "lua require('" . '<args>' . "')"

exec 'set rtp+='.s:home
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

augroup packer_user_config
	autocmd!
	autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

augroup update_bat_theme
    autocmd!
    autocmd colorscheme * if &background == 'dark' | let $BAT_THEME='OneHalfDark' | else | let $BAT_THEME='' | endif
augroup end

LoadVim vimrc
LoadVim plugin/utils.vim
LoadLua plugins
LoadLua completion
LoadLua lsp
LoadLua keymaps

command! -bang -nargs=* Tags call fzf#vim#tags(<q-args>, fzf#vim#with_preview({ 'dir': systemlist('git rev-parse --show-toplevel 2>/dev/null || pwd')[0], "placeholder": "--tag {2}:{-1}:{3..}", 'options': '--exact --select-1 --exit-0 +i'}), <bang>0)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

command! -nargs=* -bang RG        call RipgrepFzf(<q-args>, <bang>0)
command! -nargs=? -bang Pg        call ProjectGrep(<q-args>, <bang>0)
command! -nargs=? -bang GitGrep   call GitGrep(<q-args>, <bang>0)
command! -nargs=? -bang GGrep     call GitGrep(<q-args>, <bang>0)

nnoremap <silent> <leader>sd :Files<Cr>
nnoremap <silent> <leader>sh :History<CR>

call FzfGrepMap('b', 'BLines')
call FzfGrepMap('p', 'Pg')
call FzfGrepMap('t', 'Tags')
