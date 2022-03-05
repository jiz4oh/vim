if get(s:, 'loaded', 0) != 0
	finish
endif
let s:loaded = 1

set runtimepath^=~/.vim runtimepath+=~/.vim/after

let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
exec 'set runtimepath+='.s:home

let &packpath = &runtimepath

function! LoadVim(path)
  exec 'source ' . s:home.'/' . a:path
endfunction

function! LoadLua(path)
  exec 'luafile' . s:home.'/' . a:path
endfunction

function SourceConfig(configName) abort
    let l:vim_path = s:home . '/config/' . a:configName . ".vim"
    let l:lua_path = s:home . '/config/' . a:configName . ".lua"
    if filereadable(l:vim_path)
      exec 'source ' . l:vim_path
    elseif filereadable(l:lua_path)
      exec 'luafile' . l:lua_path
    endif
endfunction

function! HasInstall(plugName) abort
    " 判断插件是否已经安装在本地
    return isdirectory(g:plugs[a:plugName].dir)
endfunction

call LoadVim('config.vim')
call SourceConfig('base')
call SourceConfig('plugin')
call SourceConfig('theme')
call SourceConfig('keymap')

for plugName in g:plugs_order
    if HasInstall(plugName)
        call SourceConfig('plugin/' . plugName)
    endif
endfor

