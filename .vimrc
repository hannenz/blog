augroup blogcompile
	autocmd!
	autocmd BufWritePost *.scss !make
	autocmd BufWritePost *.md !make
	autocmd BufWritePost index.html !make
augroup END
