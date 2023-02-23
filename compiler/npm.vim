" Vim compiler file

if exists("current_compiler")
  finish
endif
let errorformat = ''
" Ignore
" npm ERR!     at /test/node_modules/puppeteer/lib/cjs/puppeteer/node/BrowserFetcher.js:115:27
let errorformat  .= '%-G%.%#ERR!%.%#at %f:%l:%c' . ','

" npm ERR! /test/node_modules/puppeteer/lib/cjs/puppeteer/node/BrowserFetcher.js:115
" npm ERR!                     throw new Error();
" npm ERR!                     ^
let errorformat  .= '%E%.%#ERR! %f:%l' . ','
let errorformat  .= '%C%.%#ERR! %#%m' . ','
let errorformat  .= '%Z%.%#ERR! %p^' . ','

" Ignore everything else
let errorformat  .= '%-G%.%#'

CompilerSet makeprg=npm
let &l:errorformat = errorformat
let current_compiler = "npm"
