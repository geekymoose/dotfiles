" ******************************************************************************
" PLUG (Plugins manager)
" ******************************************************************************
call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'vim-syntastic/syntastic'
Plug 'universal-ctags/ctags'
Plug 'Valloric/YouCompleteMe', {'for' : ['c', 'cpp'], 'do' : './install.py --clang-completer --system-libclang'}
Plug 'https://github.com/plasticboy/vim-markdown'
Plug 'https://github.com/vim-latex/vim-latex'
Plug 'https://github.com/airblade/vim-gitgutter'

" Color scheme
Plug 'https://github.com/nanotech/jellybeans.vim'
Plug 'https://github.com/tomasr/molokai'
Plug 'https://github.com/chriskempson/tomorrow-theme'
Plug 'https://github.com/altercation/solarized'
Plug 'https://github.com/chriskempson/base16-vim'

call plug#end()


" ------------------------------------------------------------------------------
" Some configurations
" ------------------------------------------------------------------------------

" vim-airline -----
let g:airline_powerline_fonts = 1
" let g:airline_powerline_fonts = 0
" let g:airline_symbols_ascii = 1
let g:airline#extensions#tabline#enabled = 1

" ctrlp -----
" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
