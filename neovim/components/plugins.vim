" ******************************************************************************
" PLUG (Plugins manager)
" ******************************************************************************
call plug#begin()
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'nanotech/jellybeans.vim'
Plug 'Valloric/YouCompleteMe', {'for' : ['c', 'cpp'], 'do' : './install.py --clang-completer --system-libclang'}
Plug 'universal-ctags/ctags'
call plug#end()

" Config for some pluggins
let g:airline_powerline_fonts = 0
let g:airline_symbols_ascii = 1
let g:airline#extensions#tabline#enabled = 1
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
