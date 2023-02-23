" Vim compiler file

if exists("current_compiler")
  finish
endif

let errorformat   = '  %l:%c%*[\ ] %m' . ','
" ERR! stack Error: Command failed: xxxx
let errorformat  .= '%+G%.%#ERR! stack Error:%m' . ','
" " ERR! stack     at ChildProcess.exithandler (child_process.js:390:12)
" let errorformat  .= '%+G%.%#ERR!%.%#(%f:%l:%c)%.%#' . ','
let errorformat  .= '%+Q✖%.%#' . ','
let errorformat  .= '%-G%.%#'

CompilerSet makeprg=yarn
let &l:errorformat = errorformat
let current_compiler = "yarn"
