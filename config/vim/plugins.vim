
call plug#begin('~/.vim/plugged')

" complete
"Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next'  }
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'ryanolsonx/vim-lsp-python', { 'for': 'python' }
Plug 'Valloric/YouCompleteMe'
" Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}

" go extension
Plug 'fatih/vim-go', { 'tag': '*', 'for': 'go' }

Plug 'rust-lang/rust.vim'

" vim mark
Plug 'inkarkat/vim-mark'
Plug 'inkarkat/vim-ingo-library'

" Lint
Plug 'w0rp/ale'

" theme
" Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'rakr/vim-one'
Plug 'NLKNguyen/papercolor-theme'
Plug 'jnurmine/Zenburn'
Plug 'lifepillar/vim-solarized8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Hightlight
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'solarnz/thrift.vim'
Plug 'vim-python/python-syntax', { 'for': 'python' }
Plug 'plasticboy/vim-markdown' " Markdown configuration

" Code format
Plug 'rhysd/vim-clang-format'
Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular'         " code align

" Code appender
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'        " cs' ds' ysiw'
Plug 'scrooloose/nerdcommenter'
Plug 'bronson/vim-trailing-whitespace' " remove trailing whitespace

" others
Plug 'myusuf3/numbers.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'zivyangll/git-blame.vim'  " ,s
Plug 'PatrickNicholas/HiCursorWords'  " highlight current word

" tips c/c++ function params
if has("nvim")
    let g:echodoc#enable_at_startup = 1
    let g:echodoc#type = 'floating'
    " To use a custom highlight for the float window,
    " change Pmenu to your highlight group
    highlight link EchoDocFloat Pmenu
else
    set noshowmode
    let g:echodoc_enable_at_startup = 1
endif
Plug 'Shougo/echodoc.vim'

" Symbol references
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

" Session Manager
Plug 'skanehira/vsession'

call plug#end()

