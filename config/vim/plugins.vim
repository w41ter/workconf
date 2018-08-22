
call plug#begin('~/.vim/plugged')

" complete
"Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next'  }
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'ryanolsonx/vim-lsp-python', { 'for': 'python' }
Plug 'Valloric/YouCompleteMe'

" go extension
Plug 'fatih/vim-go', { 'tag': '*', 'for': 'go' }

" vim mark
Plug 'inkarkat/vim-mark'
Plug 'inkarkat/vim-ingo-library'

" Lint
Plug 'w0rp/ale'

" theme
Plug 'altercation/vim-colors-solarized'
Plug 'jnurmine/Zenburn'
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
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

" Symbol references
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

call plug#end()
