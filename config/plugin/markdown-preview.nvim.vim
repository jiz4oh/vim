augroup markdown-preview-autocmd
  autocmd!

  autocmd FileType markdown let b:dispatch = ':MarkdownPreview'
augroup END
