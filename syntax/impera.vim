" Vim syntax file
" Language: Simple Imperative Language
" Maintainer: Your Name
" Latest Revision: Today's Date

if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword imperaKeyword jika atau selama prin

" Operators
syn match imperaOperator "[=+*/-]"
syn match imperaOperator "=="
syn match imperaOperator "!="
syn match imperaOperator "<"
syn match imperaOperator ">"
syn match imperaOperator "<="
syn match imperaOperator ">="

" Identifiers
syn match imperaIdentifier "[a-zA-Z_][a-zA-Z0-9_]*"

" Numbers
syn match imperaNumber "\<\d\+\>"

" Delimiters
syn match imperaDelimiter "[(){};]"

" Comments (if your language supports them, e.g., // comments)
" syn match silComment "//.*$"

" Highlighting
hi def link imperaKeyword Keyword
hi def link imperaOperator Operator
hi def link imperaIdentifier Identifier
hi def link imperaNumber Number
hi def link imperaDelimiter Delimiter
" hi def link silComment Comment

let b:current_syntax = "impera"
