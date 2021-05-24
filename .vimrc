augroup blogcompile
	autocmd!
	autocmd BufWritePost *.scss !make
	autocmd BufWritePost *.js !make
	autocmd BufWritePost *.md !make
	autocmd BufWritePost *.html !make
augroup END
