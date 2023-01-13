let g:mkdp_refresh_slow = 1

augroup markdown-preview-autocmd
  autocmd!

  autocmd FileType markdown let b:dispatch = ':MarkdownPreview'
  "override rails.vim default task for README.md
  autocmd User Rails if rails#buffer().relative() == 'README.md'|let b:dispatch = ':MarkdownPreview'|endif
augroup END
