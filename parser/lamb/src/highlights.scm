[
 "(" @punctuation.bracket
 ")" @punctuation.bracket
]

[
 "λ" @keyword
 "." @keyword
]

; [
;  "define"
;  "writeln"
; ] @keyword

(lambda
  param: (var) @variable.parameter)

(application
  func: (expr) @function)

; (var) @identifier
