syn match latexLabelBlock '\\label{.\{-}}' contained containedin=markdownLinkText,markdownH1,markdownH2,markdownH3,markdownH4,markdownH5,markdownH6,pandocTableTitle
syn match latexLabelBlockHead /\\label{/ contained containedin=latexLabelBlock conceal cchar= 
syn match latexLabelBlockTail /}/ contained containedin=latexLabelBlock conceal
hi latexLabelBlock cterm=italic ctermfg=240 ctermbg=234 gui=italic guifg=#5A5A5A guibg=bg


syn match pandocFootnoteDef /\[\^[^\]]\+\]/ 
syn match pandocFootnoteDefHead /\[\^/ contained containedin=pandocFootnoteDef conceal cchar=†
syn match pandocFootnoteDefTail /\]/ contained containedin=pandocFootnoteDef conceal

syn region pandocFootnoteBlock start=/\[\^.\{-}\]:\s*\n*/ end=/^\n^\s\@!/
syn match pandocFootnoteBlockSeparator /:/ contained containedin=pandocFootnoteBlock
syn match pandocFootnoteID /\[\^.\{-}\]/ contained containedin=pandocFootnoteBlock
syn match pandocFootnoteIDHead /\[\^/ contained containedin=pandocFootnoteID conceal cchar=†
syn match pandocFootnoteIDTail /\]/ contained containedin=pandocFootnoteID conceal


syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart,markdownImageIcon
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal cchar= 
syn region markdownId matchgroup=markdownIdDelimiter start="\[" end="\]" keepend contained 
syn region markdownAutomaticLink matchgroup=markdownUrlDelimiter start="<\%(\w\+:\|[[:alnum:]_+-]\+@\)\@=" end=">" keepend oneline
syn match markdownImageIcon /!/ conceal cchar=
syn match latexImageFormat /{.\{-}}$/ conceal
hi markdownLinkTextDelimiter ctermfg=240 ctermbg=234 guifg=#5A5A5A guibg=bg

syn match pandoc_cite '\[@.*\]' conceal cchar=

syn match pandocTableTitle 'Table:.*'
hi link pandocTableTitle markdownLinkText

hi pandocFootnoteBlock ctermfg=240 ctermbg=234 guifg=#5A5A5A guibg=bg
hi pandocFootnoteIDHead ctermfg=240 ctermbg=234 guifg=#5A5A5A guibg=bg
hi pandocFootnoteIDTail ctermfg=240 ctermbg=234 guifg=#5A5A5A guibg=bg
hi pandocFootnoteID ctermfg=240 ctermbg=234 guifg=#5A5A5A guibg=bg
hi pandocFootnoteBlockSeparator ctermfg=240 ctermbg=234 guifg=#5A5A5A guibg=bg
hi markdownFootnote ctermfg=240 ctermbg=234 guifg=#5A5A5A guibg=bg
hi pandocFootnoteDef term=bold ctermfg=176 guifg=#C586C0
hi pandocFootnoteDefHead term=bold ctermfg=176 guifg=#C586C0
hi pandocFootnoteDefTail term=bold ctermfg=176 guifg=#C586C0

try
    unlet! b:current_syntax
    syn include @YAML syntax/yaml.vim
catch /E484/
endtry
syn region pandocYAMLHeader start=/\%(\%^\|\_^\s*\n\)\@<=\_^-\{3}\ze\n.\+/ end=/^\([-.]\)\1\{2}$/ keepend contains=@YAML containedin=TOP

" Set embedded LaTex (pandoc extension) highlighting
" Unset current_syntax so the 2nd include will work
unlet b:current_syntax
syn include @LATEX syntax/tex.vim
syn region pandocLaTeXInlineMath start=/\v\\@<!\$\S@=/ end=/\v\\@<!\$\d@!/ keepend contains=@LATEX
syn region pandocLaTeXInlineMath start=/\\\@<!\\(/ end=/\\\@<!\\)/ keepend contains=@LATEX
syn match pandocEscapedDollar /\\\$/ conceal cchar=$
syn match pandocProtectedFromInlineLaTeX /\\\@<!\${.*}\(\(\s\|[[:punct:]]\)\([^$]*\|.*\(\\\$.*\)\{2}\)\n\n\|$\)\@=/ display
" contains=@LATEX
syn region pandocLaTeXMathBlock start=/\$\$/ end=/\$\$/ keepend contains=@LATEX
syn region pandocLaTeXMathBlock start=/\\\@<!\\\[/ end=/\\\@<!\\\]/ keepend contains=@LATEX
syn match pandocLaTeXCommand /\\[[:alpha:]]\+\(\({.\{-}}\)\=\(\[.\{-}\]\)\=\)*/ contains=@LATEX
syn region pandocLaTeXRegion start=/\\begin{\z(.\{-}\)}/ end=/\\end{\z1}/ keepend contains=@LATEX
" we rehighlight sectioning commands, because otherwise tex.vim captures all text until EOF or a new sectioning command
syn region pandocLaTexSection start=/\\\(part\|chapter\|\(sub\)\{,2}section\|\(sub\)\=paragraph\)\*\=\(\[.*\]\)\={/ end=/\}/ keepend
syn match pandocLaTexSectionCmd /\\\(part\|chapter\|\(sub\)\{,2}section\|\(sub\)\=paragraph\)/ contained containedin=pandocLaTexSection
syn match pandocLaTeXDelimiter /[[\]{}]/ contained containedin=pandocLaTexSection

hi HtmlH1 term=bold cterm=bold ctermfg=9 gui=bold guifg=#e08090 guibg=bg
hi HtmlH2 term=bold cterm=bold ctermfg=10 gui=bold guifg=#80e090 guibg=bg
hi HtmlH3 term=bold cterm=bold ctermfg=12 gui=bold guifg=#6090e0 guibg=bg
hi HtmlH4 term=bold cterm=bold ctermfg=15 gui=bold guifg=#c0c0f0 guibg=bg
hi HtmlH5 term=bold cterm=bold ctermfg=15 gui=bold guifg=#e0e0f0 guibg=bg
hi HtmlH6 term=bold cterm=bold ctermfg=15 gui=bold guifg=#f0f0f0 guibg=bg

syn match latexRefBlock '\\ref{.\{-}}' 
syn match latexRefBlockHead /\\ref{/ contained containedin=latexRefBlock conceal
syn match latexRefBlockTail /}/ contained containedin=latexRefBlock conceal
hi latexRefBlock term=bold cterm=italic ctermfg=176 gui=italic guifg=#C586C0

syn match latextPagerefBlock '\\pageref{.\{-}}' conceal cchar=#
hi latextPagerefBlock term=bold cterm=italic ctermfg=176 gui=italic guifg=#C586C0

syn match latextPageBreak '\\clearpage' conceal cchar=§
hi latextPageBreak term=bold cterm=italic ctermfg=176 gui=italic guifg=#C586C0

hi Conceal ctermfg=240 ctermbg=234 guifg=#5A5A5A guibg=bg

" Don't count acronyms / abbreviations as spelling errors
 " (all upper-case letters, at least two characters)
 " Also will not count acronym with 's' at the end a spelling error
 " Also will not count numbers that are part of this
 " Recognizes the following as correct:
 syn match AcronymNoSpell '\<\(\u\|\d\)\{2,}s\?\>' contains=@NoSpell

" Don't mark URL-like things as spelling errors
 syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell
