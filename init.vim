if get(g:, 'vimrc_loaded', 0) != 0
	finish
endif
let g:vimrc_loaded = 1

let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

exec 'source ' . s:home . '/config.vim'

function SourceConfig(configName) abort
    let l:vim_path = s:home . '/config/' . a:configName . ".vim"
    let l:lua_path = s:home . '/config/' . a:configName . ".lua"
    if filereadable(l:vim_path)
      exec 'source ' . l:vim_path
    elseif has('nvim') && filereadable(l:lua_path)
      exec 'luafile' . l:lua_path
    endif
endfunction

function! HasInstall(plugName) abort
    let spec = get(get(g:, 'plugs', {}), a:plugName, {})
    if empty(spec)
      return 0
    endif
    " 判断插件是否已经安装在本地
    return isdirectory(g:plugs[a:plugName].dir)
endfunction

call SourceConfig('base')
call SourceConfig('plugin')

augroup PlugLazyLoad
  autocmd!

  if exists('g:plugs_order')
    for plugName in g:plugs_order
      if HasInstall(plugName)
        let spec = g:plugs[plugName]
        "TODO plug.vim 内部判断某个插件是否 lazy，不只是判断是否有 on 或者 for
        " if has_key(spec, 'on') || has_key(spec, 'for')
        "   execute 'autocmd User ' . plugName . ' call SourceConfig("plugin/' . plugName . '")'
        " else
          call SourceConfig('plugin/' . plugName)
        " endif
      endif
    endfor
  endif
augroup END

exec 'set runtimepath^='.s:home
" remove ~/.vim/after in the end
exec 'set runtimepath='.join(split(&runtimepath, ',')[0:-2], ',')
exec 'set runtimepath+='.s:home .'/after,~/.vim/after'
let &packpath = &runtimepath

if filereadable($HOME . '/.vimrc.local')
  exec 'source' $HOME . '/.vimrc.local'
endif

command! -nargs=0 -bar ConfigUpgrade call personal#config#upgrade()
