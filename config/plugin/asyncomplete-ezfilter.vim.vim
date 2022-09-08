let g:asyncomplete_preprocessor =
  \ [function('asyncomplete#preprocessor#ezfilter#filter')]

let g:asyncomplete#preprocessor#ezfilter#config = {}
let g:asyncomplete#preprocessor#ezfilter#config['*'] =
  \ {ctx, items -> ctx.filter(items)}
