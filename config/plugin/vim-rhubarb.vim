augroup rhubarb-augroup
  autocmd!

  autocmd FileType fugitive map <buffer><expr> <leader>gp ':GBrowse ' . rhubarb#HomepageForUrl(fugitive#RemoteUrl()) . '/pull/new/' . FugitiveHead() . '<cr>'
augroup END
