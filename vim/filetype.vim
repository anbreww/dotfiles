if exists("did_load_filetypes")
	finish
endif
augroup	filetypedetect
	au! BufNewFile,BufRead *.ly	setf lilypond
augroup END

" Markdown Syntax
augroup markdown
	au! BufNewFile,BufRead *.md	setf mkd
augroup END
