
let s:headersRegexp = '\v^(#|.+\n(\=+|-+)$)'

" Returns the line number of the first header before `line`, called the
" current header.
"
" If there is no current header, return `0`.
"
" @param a:1 The line to look the header of. Default value: `getpos('.')`.
"
function! s:GetHeaderLineNum(...)
    if a:0 == 0
        let l:l = line('.')
    else
        let l:l = a:1
    endif
    while(l:l > 0)
        if join(getline(l:l, l:l + 1), "\n") =~ s:headersRegexp
            return l:l
        endif
        let l:l -= 1
    endwhile
    return 0
endfunction

" -  if inside a header goes to it.
"    Return its line number.
"
" -  if on top level outside any headers,
"    print a warning
"    Return `0`.
"
function! s:MoveToCurHeader()
    let l:lineNum = s:GetHeaderLineNum()
    if l:lineNum != 0
        call cursor(l:lineNum, 1)
    else
        echo 'outside any header'
        "normal! gg
    endif
    return l:lineNum
endfunction

" Move cursor to next header of any level.
"
" If there are no more headers, print a warning.
"
function! s:MoveToNextHeader()
    if search(s:headersRegexp, 'W') == 0
        "normal! G
        echo 'no next header'
    endif
endfunction

" Move cursor to previous header (before current) of any level.
"
" If it does not exist, print a warning.
"
function! s:MoveToPreviousHeader()
    let l:curHeaderLineNumber = s:GetHeaderLineNum()
    let l:noPreviousHeader = 0
    if l:curHeaderLineNumber <= 1
        let l:noPreviousHeader = 1
    else
        let l:previousHeaderLineNumber = s:GetHeaderLineNum(l:curHeaderLineNumber - 1)
        if l:previousHeaderLineNumber == 0
            let l:noPreviousHeader = 1
        else
            call cursor(l:previousHeaderLineNumber, 1)
        endif
    endif
    if l:noPreviousHeader
        echo 'no previous header'
    endif
endfunction

nmap <buffer> [[ :call <sid>MoveToPreviousHeader()<cr>
nmap <buffer> ]] :call <sid>MoveToNextHeader()<cr>
nmap <buffer> [] :call <sid>MoveToCurHeader()<cr>

