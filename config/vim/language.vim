func! PythonSettings()
	let g:python_highlight_all=1

	call SpaceSetting()

	if executable('pyls')
		autocmd User lsp_setup call lsp#register_server({
			\ 'name': 'pyls',
			\ 'cmd': {server_info->['pyls']},
			\ 'whitelist': ['python'],
			\ })
	endif
endfunc

func! CLikeSettings()
	call SpaceSetting()
	call CppHighlightEnhanced()
	call EnableClangFormatSettings()
	" call CLikeLintSettings()
	call CLikeAutoComplete()
    " 
	" let g:lsp_log_verbose = 1
	" let g:lsp_log_file = expand('~/vim-lsp.log')

	" if executable('ccls')
	"     autocmd User lsp_setup call lsp#register_server({
	"         \ 'name': 'ccls',
	"         \ 'cmd': {server_info->['ccls']},
	"         \ 'root_uri': {server_info->FindRootPathUri(['compile_commands.json', 'build/compile_commands.json'])},
	"         \ 'initialization_options': {
	"             \ 'cacheDirectory': '/tmp/ccls/cache',
	"             \ 'index': {'threads': 2, 'comments': 0},
	"             \ "diagnostics": { "onChange": -1, },
	"             \ },
	"         \ 'whitelist': ['c', 'cpp', 'cc', 'h'],
	"         \ })
	" endif

	if executable('cquery')
		autocmd User lsp_setup call lsp#register_server({
			\ 'name': 'cquery',
			\ 'cmd': {server_info->['cquery']},
			\ 'root_uri': {server_info->FindRootPathUri(['compile_commands.json', 'build/compile_commands.json'])},
			\ 'initialization_options': {
				\ 'cacheDirectory': '/tmp/cquery/cache',
				\ 'index': {'threads': 2, 'comments': 0},
				\ 'diagnostics': { 'onChange': -1 },
				\ },
			\ 'whitelist': ['c', 'cpp', 'cc', 'h'],
			\ })
	endif
endfunc

func! GolangSettings()
	" auto BufWritePre *.go :0,$!gofmt

	call GolangKeyMap()
	call TabSetting()

	" vim-go settings
	let g:go_highlight_extra_types=1
	let g:go_highlight_operators=1
	let g:go_highlight_functions=1
	let g:go_highlight_function_arguments=1
	let g:go_highlight_function_calls=1
	let g:go_highlight_types=1
	let g:go_highlight_fields=1
	let g:go_highlight_build_constraints=1
	let g:go_highlight_generate_tags=1
	let g:go_highlight_string_spellcheck=1
	let g:go_highlight_format_strings=1
	let g:go_highlight_variable_declarations=1
	let g:go_highlight_variable_assignments=1

	if executable('go-langserver')
		autocmd User lsp_setup call lsp#register_server({
			\ 'name': 'go-langserver',
			\ 'cmd': {server_info->['go-langserver', '-mode', 'stdio']},
			\ 'whitelist': ['go'],
			\ })
	endif
endfunc

func! ClojureSettings()
	call SpaceSettingWith(2)
endfunc

func! RustSettings()
	call SpaceSetting()

	if executable('rls')
		autocmd User lsp_setup call lsp#register_server({
			\ 'name': 'rls',
			\ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
			\ 'whitelist': ['rust'],
			\ })
	endif
endfunc

augroup AutoLoadLanguageSettings
	autocmd!
	autocmd FileType c,cpp :call CLikeSettings()
	autocmd FileType python :call PythonSettings()
	autocmd FileType golang :call GolangSettings()
	autocmd FileType clojure :call ClojureSettings()
	autocmd FileType rust :call RustSettings()
augroup END
