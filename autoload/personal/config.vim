function! personal#config#upgrade() abort
  echo 'Downloading the latest config'
  redraw
  let tmp = resolve(fnamemodify(g:config_dir, ":p:h:h")) . '/vim_config_tmp'

  try
    let out = system('git clone --depth 1 '. g:config_src . ' ' . tmp)
    if v:shell_error
      echoerr 'Error upgrading configuration: '. out
      return
    endif

    call system('rm -rf '. g:config_dir . '.old')
    call rename(g:config_dir, g:config_dir . '.old')
    call rename(tmp, g:config_dir)
    unlet g:vimrc_loaded
    echo 'configuration has been upgraded'
    return 1
  finally
    if isdirectory(l:tmp)
      call system('rm -rf '. l:tmp)
    endif
  endtry
endfunction

