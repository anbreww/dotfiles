" fix input of é, â, etc

" \item
imap <C-i> <Plug>Tex_InsertItemOnThisLine
" \mathbf
imap <C-b> <Plug>Tex_MathBF
" \cite
imap <C-c> <Plug>Tex_MathCal
" \label
imap <C-l> <Plug>Tex_LeftRight

" just a bit of indentation
set sw=2
" 80 characters wide
set tw=80

set grepprg=grep\ -nH\ $*
