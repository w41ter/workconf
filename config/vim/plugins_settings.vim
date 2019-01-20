func! FindRootPathUri(relative_path)
	let buffer_path = lsp#utils#get_buffer_path()
	for path in a:relative_path
		let commands_path = lsp#utils#find_nearest_parent_file_directory(buffer_path, path)
		if !empty(commands_path)
			return lsp#utils#path_to_uri(commands_path)
		endif
	endfor
	return ''
endfunc

func! ALELintSettings()
	" lint settings
	let g:ale_sign_column_always=1
	let g:ale_set_highlights=0
	let g:ale_sign_error = '✗'
	let g:ale_sign_warning = '⚡'
	let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
endfunc

func! LspLintSettings()
	let g:lsp_signs_enabled = 1         " enable signs
	let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

	let g:lsp_signs_error = {'text': '✗'}
	let g:lsp_signs_warning = {'text': '⚡'}
	let g:lsp_signs_hint = {'text': '✔ '}
endfunc

func! CLikeALELintSettings()
	" disable other lint tools
	let g:ale_cpp_clang_executable = ''
	let g:ale_cpp_clangd_executable = ''
	let g:ale_cpp_clangcheck_executable = ''
	let g:ale_cpp_clazy_executable = ''
	let g:ale_cpp_cppcheck_executable = ''
	let g:ale_cpp_cpplint_executable = ''
	let g:ale_cpp_cquery_executable = ''
	let g:ale_cpp_flawfinder_executable = ''
	let g:ale_cpp_gcc_executable = ''
	let g:ale_cpp_clangtidy_executable = ''

	if executable('clang-tidy')
		" enable clang-tidy support
		let g:ale_c_build_dir_names = ['build']
		let g:ale_cpp_clangtidy_checks = ['-checks']
		let g:ale_cpp_clangtidy_executable = 'clang-tidy'
	endif
endfunc

func! MotionSettings()
	" EsayMontion configuration
	map f <Plug>(easymotion-prefix)
	map ff <Plug>(easymotion-s)
	map fs <Plug>(easymotion-f)
	map fl <Plug>(easymotion-lineforward)
	map fj <Plug>(easymotion-j)
	map fk <Plug>(easymotion-k)
	map fh <Plug>(easymotion-linebackward)
	let g:EasyMotion_smartcase = 1
endfunc

func! SymbolReferences()
	let g:gutentags_enabled = 1
	let g:gutentags_project_root = ['.root', '.git']
	let g:gutentags_ctags_tagfile = '.tags'
	let g:gutentags_modules = []
	if executable('ctags')
		let g:gutentags_modules += ['ctags']
	endif
	let s:vim_tags = expand('~/.cache/tags')
	let g:gutentags_cache_dir = s:vim_tags
	let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
	let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
	let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
	let g:gutentags_ctags_extra_args += ['--languages=C,C++,Go,Rust,Asm,Vim']
	let g:gutentags_ctags_extra_args += ['--exclude={.git,node_modules,build,third,thirdparty}']

	let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

	if !isdirectory(s:vim_tags)
		silent! call mkdir(s:vim_tags, 'p')
	endif

	set tags=./.tags;,.tags
endfunc

func! YCMAutoComplete()
	let g:ycm_add_preview_to_completeopt = 0
	let g:ycm_show_diagnostics_ui = 0
	let g:ycm_server_log_level = 'info'
	let g:ycm_min_num_identifier_candidate_chars = 2
	let g:ycm_collect_identifiers_from_comments_and_strings = 1
	let g:ycm_collect_identifiers_from_tags_files=1
	let g:ycm_complete_in_strings=1
	let g:ycm_max_num_candidates=10
	let g:ycm_key_invoke_completion = '<c-z>'
	let g:ycm_global_ycm_extra_conf = '~/.vim/config/.ycm_extra_conf.py'
	set completeopt=menu,menuone

	let g:ycm_semantic_triggers = {
		\ 'c,cc,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
		\ 'cs,lua,javascript': ['re!\w{2}'],
		\ 'py': ['re!\w{2}'],
		\ 'clojure': ['re!\w{1}'],
		\ }
	let g:ycm_filetype_whitelist = {
		\ 'c': 1,
		\ 'h': 1,
		\ 'cpp': 1,
		\ 'cc': 1,
		\ 'py': 1,
		\ 'go': 1,
		\ 'rs': 1,
		\ 'sh': 1,
		\ 'vim': 1,
		\ 'python': 1,
		\ 'thrift': 1,
		\ 'proto': 1,
		\ 'cmake': 1,
		\ 'clojure': 1,
		\ }
endfunc

func! CLikeAutoComplete()
endfunc

func! CppHighlightEnhanced()
	let g:cpp_class_scope_highlight=1
	let g:cpp_member_variable_highlight = 1
	let g:cpp_class_decl_highlight = 1
	let g:cpp_experimental_template_highlight = 1
	let g:cpp_concepts_highlight = 1
endfunc

func! NERDSettings()
	let g:NERDSpaceDelims = 1
	let g:NERDCompactSexyComs = 1
	let g:NERDDefaultAlign = 'left'
	let g:NERDCommentEmptyLines = 1

	let g:NERDTreeShowLineNumbers = 1
	let g:NERDTreeIgnore = ['\.pyc$']
endfunc

func! TagbarSettings()
	let g:tagbar_show_visibility = 1
	let g:tagbar_show_linenumbers = -1 " use global numbers settings
endfunc

func! LeaderFSettings()

endfunc

func! LintSettings()
	call ALELintSettings()
	" call LspLintSettings()
endfunc

call LintSettings()
call MotionSettings()
call SymbolReferences()
call YCMAutoComplete()
call NERDSettings()
call TagbarSettings()
