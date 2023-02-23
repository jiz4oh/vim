" Vim compiler file

if exists("current_compiler")
  finish
endif

CompilerSet errorformat=
      \%m\ \ Created:\ %f,
      \%*[\ ]%m\ (%f:%l:%c),
      \%*[\ ]at\ %f:%l:%c,
      \%-G%.%#

CompilerSet makeprg=hexo
let current_compiler = "hexo"
