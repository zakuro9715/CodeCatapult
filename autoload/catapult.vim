let s:save_cpo = &cpo
set cpo&vim

function! s:getlang()
  let ft = &filetype
  if ft == "c"
    return "C"
  elseif ft == "cpp"
    return "C%2b%2b"
  elseif ft == "java"
    return "JAVA"
  elseif ft == "cs"
    return "C#%23"
  elseif ft == "d"
    return "D"
  elseif ft == "ruby"
    return "Ruby"
  elseif ft == "python"
    return "Python"
  elseif ft == "php"
    return "PHP"
  elseif ft == "javascript"
    return "JavaScript"
  endif
  return ""
endfunction

function! s:getsource()
  let s = ""
  let lines = getline(0, line("$"))
  for i in lines
    let s = s . "\n" . i
  endfor
  let s = substitute(s, '\\', '\\\\', "g")
  let s = substitute(s, '\"', '\\\"', "g")
  let s = substitute(s, "%", "%25", "g")
  let s = substitute(s, "&", "%26", "g")
  let s = substitute(s, "+", "%2b", "g")
  return s
endfunction

function! catapult#submit(id, password, prb)
  let lang = s:getlang()
  let source = s:getsource()
  let command = iconv("wget  --post-data=\"" . "userID=" . a:id . "&password=" . a:password . "&problemNO=" . a:prb . "&language=" . lang . "&sourceCode=" . source . "\" http://judge.u-aizu.ac.jp/onlinejudge/servlet/Submit -O -", &encoding, "shift-jis")
  call system(command)
  call system("xdg-open http://judge.u-aizu.ac.jp/onlinejudge/status.jsp")
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
