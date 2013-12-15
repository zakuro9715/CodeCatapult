if exists('g:loaded_code_catapult')
  "finish
endif
let g:loaded_code_catapult = 1

let s:save_cpo = &cpo
set cpo&vim

let s:userid = "userid"
let s:password = "password"

command! -nargs=1 ThrowToAizu call 
      \ catapult#submit(s:userid, s:password, <f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo
