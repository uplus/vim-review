if exists('g:loaded_review')
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

function! ReVIEWCaption(level)
  let level = a:level
  let orig = getline(".")
  let repl = substitute(orig, '^=*\s*', " ", "")
  while level > 0
    let repl = "=" . repl
    let level = level - 1
  endwhile
  call append(".", repl)
  execute ":d"
endfunction
function! ReVIEWEndOfBlock(line)
  call append(a:line, "//}")
endfunction
function! ReVIEWList() range
  call ReVIEWEndOfBlock(a:lastline)
  call append(a:firstline-1, '//list[][]{')
endfunction
function! ReVIEWEmlist() range
  call ReVIEWEndOfBlock(a:lastline)
  call append(a:firstline-1, '//emlist{')
endfunction
function! ReVIEWCmd() range
  call ReVIEWEndOfBlock(a:lastline)
  call append(a:firstline-1, '//cmd{')
endfunction
function! ReVIEWTable() range
  call ReVIEWEndOfBlock(a:lastline)
  call append(a:firstline-1, '//table[][]{')
  call append(a:firstline, '----')
endfunction

if !get(g:, 'review_no_default_key_mappings', 0)
  map <silent><buffer>gh1 :call ReVIEWCaption(1)
  map <silent><buffer>gh2 :call ReVIEWCaption(2)
  map <silent><buffer>gh3 :call ReVIEWCaption(3)
  map <silent><buffer>gh4 :call ReVIEWCaption(4)
  map <silent><buffer>gl :call ReVIEWList()
  map <silent><buffer>ge :call ReVIEWEmlist()
  map <silent><buffer>gc :call ReVIEWCmd()
  map <silent><buffer>gt :call ReVIEWTable()
endif

if exists('*SurroundRegister')
  call SurroundRegister('b', 't', "@<tt>{\r}")
  call SurroundRegister('b', 'k', "@<kw>{\r}")
  call SurroundRegister('b', 'f', "@<fn>{\r}")
  call SurroundRegister('b', 'l', "@<list>{\r}")
  call SurroundRegister('b', 'i', "@<i>{\r}")
  call SurroundRegister('b', 're', "@<recipe>{\r}")
endif

let &cpo = s:save_cpo
unlet s:save_cpo
let g:loaded_review = 1
