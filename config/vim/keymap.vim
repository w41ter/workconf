let mapleader=' '

" Window move
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Line move
nnoremap <leader>k ddkP
nnoremap <leader>j ddp

" Close quickfix
" F1 -> Help
nnoremap <silent> <F7> :ccl<CR>
nnoremap <silent> <F8> :NERDTreeToggle<CR>
nnoremap <silent> <F9> :TagbarToggle<CR>

" remove trailing-whitespace and save
nnoremap <leader>s :FixWhitespace<CR>:w<CR>

" TODO: unap upper letter

func! LspKeyMap()
	nnoremap <leader>gd :LspDefinition<CR>
	nnoremap <leader>gh :LspHover<CR>
	nnoremap <leader>gi :LspImplementation<CR>
	nnoremap <leader>gu :LspReferences<CR>
	nnoremap <leader>ge :LspDocumentDiagnostics<CR>
	nnoremap <leader>gr :LspRename<CR>
	nnoremap <leader>gs :LspDocumentSymbol<CR>
endfunc

func! EnableClangFormatSettings()
	nnoremap <buffer><F5> :<C-u>ClangFormat<CR>
	vnoremap <buffer><F5> :ClangFormat<CR>
endfunc

func! GolangKeyMap()
	nnoremap <buffer><F6> :GoImports<CR>
	nnoremap <buffer><F5> :GoFmt<CR>
endfunc

func! YCMKeyMap()
	nnoremap <leader>gd :YcmCompleter GoTo<CR>
	nnoremap <leader>gth :YcmCompleter GoToInclude<CR>
	nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
endfunc

call LspKeyMap()
