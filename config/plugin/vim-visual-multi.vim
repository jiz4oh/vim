" 1. 使用ctrl n来选择当前光标下的单词，使用n进行向下选择，使用N向上选择,
" 2. alt n/p 垂直多选
" 3. ]/[ 在所有光标之间进行跳转
" 4. q，跳过当前选择并将光标移动到下一个选择处
" 5. Q，仅仅取消当前选择不移动下一处
" 6. 使用tab可以在光标模式和visual模式之间进行跳转
" 7. 多光标选中之后使用s可以进行扩展选择，比如siw，si'等
"
let g:VM_theme='ocean'
let g:VM_maps                       = {}
let g:VM_maps["Undo"]               = 'u'
let g:VM_maps["Redo"]               = 'U'
let g:VM_maps["Find Under"]         = 'gb'
let g:VM_maps["Find Subword Under"] = 'gb'
let g:VM_maps["Add Cursor Down"]    = '<C-n>'
let g:VM_maps["Add Cursor Up"]      = '<C-p>'

