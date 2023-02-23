augroup PlugLazyLoad
  if exists('g:plugs_order')
    for plugName in g:plugs_order
      if HasInstall(plugName)
        let spec = g:plugs[plugName]
        "TODO plug.vim 内部判断某个插件是否 lazy，不只是判断是否有 on 或者 for
        " if has_key(spec, 'on') || has_key(spec, 'for')
        "   execute 'autocmd User ' . plugName . ' call SourceConfig("plugin/' . plugName . '")'
        " else
          call SourceConfig('after/plugin/' . plugName)
        " endif
      endif
    endfor
  endif
augroup END
