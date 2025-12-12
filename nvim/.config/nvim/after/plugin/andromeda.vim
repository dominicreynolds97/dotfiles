
" If you are distributing this theme, please replace this comment
" with the appropriate license attributing the original VS Code
" theme author.


" Andromeda - A nice dark theme

" ==========> Reset
set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = 'andromeda'

" ==========> Highlight function
function! s:h(face, guibg, guifg, ctermbg, ctermfg, gui)
  let l:cmd="highlight " . a:face
  
  if a:guibg != ""
    let l:cmd = l:cmd . " guibg=" . a:guibg
  endif

  if a:guifg != ""
    let l:cmd = l:cmd . " guifg=" . a:guifg
  endif

  if a:ctermbg != ""
    let l:cmd = l:cmd . " ctermbg=" . a:ctermbg
  endif

  if a:ctermfg != ""
    let l:cmd = l:cmd . " ctermfg=" . a:ctermfg
  endif

  if a:gui != ""
    let l:cmd = l:cmd . " gui=" . a:gui
  endif

  exec l:cmd
endfun


" ==========> Colors dictionary

" GUI colors dictionary (hex)
let s:hex = {}
" Terminal colors dictionary (256)
let s:bit = {}

let s:hex.color0="#23262E"
let s:hex.color1="#D5CED9"
let s:hex.color2="#50535b"
let s:hex.color3="#2d3038"
let s:hex.color4="#555860"
let s:hex.color5="#373a42"
let s:hex.color6="#696c74"
let s:hex.color7="#6e7179"
let s:hex.color8="#ebd259"
let s:hex.color9="#41444c"
let s:hex.color10="#f3ecf7"
let s:hex.color11="#dfd8e3"
let s:hex.color12="#464951"
let s:hex.color13="#5f6167"
let s:hex.color14="#ee5d43"
let s:hex.color15="#00e8c6"
let s:hex.color16="#FFE66D"
let s:hex.color17="#c74ded"
let s:hex.color18="#96E072"
let s:hex.color19="#f39c12"

let s:bit.color14="44"
let s:bit.color17="113"
let s:bit.color16="171"
let s:bit.color7="185"
let s:bit.color1="188"
let s:bit.color13="203"
let s:bit.color18="214"
let s:bit.color15="221"
let s:bit.color0="235"
let s:bit.color3="236"
let s:bit.color4="237"
let s:bit.color8="238"
let s:bit.color11="239"
let s:bit.color2="240"
let s:bit.color12="241"
let s:bit.color5="242"
let s:bit.color6="243"
let s:bit.color10="253"
let s:bit.color9="255"


" ==========> General highlights 
call s:h("Normal", s:hex.color0, s:hex.color1, s:bit.color0, s:bit.color1, "none")
call s:h("Visual", s:hex.color2, "", s:bit.color2, "", "none")
call s:h("ColorColumn", s:hex.color3, "", s:bit.color3, "", "none")
call s:h("LineNr", "", s:hex.color4, "", s:bit.color2, "none")
call s:h("CursorLine", s:hex.color5, "", s:bit.color4, "", "none")
call s:h("CursorLineNr", "", s:hex.color6, "", s:bit.color5, "none")
call s:h("CursorColumn", s:hex.color5, "", s:bit.color4, "", "none")
call s:h("VertSplit", "", s:hex.color7, "", s:bit.color6, "none")
call s:h("Folded", s:hex.color5, s:hex.color8, s:bit.color4, s:bit.color7, "none")
call s:h("Pmenu", s:hex.color9, s:hex.color10, s:bit.color8, s:bit.color9, "none")
call s:h("PmenuSel", s:hex.color3, s:hex.color11, s:bit.color3, s:bit.color10, "none")
call s:h("EndOfBuffer", s:hex.color0, s:hex.color12, s:bit.color0, s:bit.color11, "none")
call s:h("NonText", s:hex.color0, s:hex.color12, s:bit.color0, s:bit.color11, "none")


" ==========> Syntax highlights
call s:h("Comment", "", s:hex.color13, "", s:bit.color12, "none")
call s:h("Constant", "", s:hex.color14, "", s:bit.color13, "none")
call s:h("Special", "", s:hex.color14, "", s:bit.color13, "none")
call s:h("Identifier", "", s:hex.color15, "", s:bit.color14, "none")
call s:h("Function", "", s:hex.color16, "", s:bit.color15, "none")
call s:h("Statement", "", s:hex.color17, "", s:bit.color16, "none")
call s:h("Operator", "", s:hex.color14, "", s:bit.color13, "none")
call s:h("PreProc", "", s:hex.color17, "", s:bit.color16, "none")
call s:h("Type", "", s:hex.color17, "", s:bit.color16, "none")
call s:h("String", "", s:hex.color18, "", s:bit.color17, "none")
call s:h("Number", "", s:hex.color19, "", s:bit.color18, "none")

highlight link cStatement Statement
highlight link cSpecial Special


" Generated using https://github.com/nice/themeforge
" Feel free to remove the above URL and this line.
