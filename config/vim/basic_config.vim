set nocompatible
set backspace=2

" highlight settings
syntax enable
set background=dark
set termguicolors
" let g:solarized_termcolors=256
" colorscheme solarized8
colorscheme zenburn

set number
set showmatch
set cursorcolumn
set cursorline
set colorcolumn=121
set hlsearch
set incsearch

" display tab with |
set list
set listchars=tab:\|\ ,
highlight LeaderTab guifg=#aaaaaa

" show command
set showcmd

" basic settings
set encoding=utf-8
set wrap
set scrolloff=5
set ve=block
set fileformat=unix

set nobackup
set noswapfile

function TabSetting()
    set shiftwidth=4    " how many space insert when you press tab
    set tabstop=4       " how many space tab stop at
    set softtabstop=4   " 12 replace by \t <sp><sp><sp><sp>
    set noexpandtab     " do not use space replace tab
    " set smarttab      guess tab by exists <sp> to setting above settings.
endfunction

function SpaceSetting()
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    set expandtab       " use space replace tab
endfunction

func! SpaceSettingWith(stop)
	let &shiftwidth=a:stop
	let &tabstop=a:stop
	let &softtabstop=a:stop
	set expandtab
endfunc

function ChangeBackground()
    let &background = ( &background == "dark"? "light" : "dark" )
endfunc

function ChangeColorColumn(column)
	let &colorcolumn = a:column
endfunc

" default setting of tab
call TabSetting()

" indent setting:
" autoindent
" smartindent    notice {}
" cindent        usefull for c
set autoindent

" Enable code folding
set foldmethod=indent
set foldlevel=99
