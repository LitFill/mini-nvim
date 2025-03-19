if exists("b:current_syntax")
    finish
endif

" '=' sign
syntax match cclEq /=/

" ccl keys
syntax match cclKey /^\s*\zs[^=\n]\+\ze\*=/ containedin=ALL

" ccl values
syntax region cclVal matchgroup=cclEq start=/=\s*/ end=/$/ contains=NONE

" ccl line comment
syntax match cclComment "/=.*$"

" linking highlight
hi def link cclKey     Identifier
hi def link cclEq      Operator
hi def link cclVal     String
hi def link cclComment Comment

let b:current_syntax = "ccl"

