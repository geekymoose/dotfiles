" ******************************************************************************
" PLUG (Plugins manager)
" ******************************************************************************
call plug#begin('~/.config/nvim/plugged')

Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/jeetsukumaran/vim-buffergator'
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'https://github.com/universal-ctags/ctags'
Plug 'https://github.com/Valloric/YouCompleteMe', {'for' : ['c', 'cpp'], 'do' : './install.py --clang-completer --system-libclang'}
Plug 'https://github.com/plasticboy/vim-markdown'
Plug 'https://github.com/vim-latex/vim-latex'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'https://github.com/junegunn/vim-easy-align'
Plug 'https://github.com/kien/rainbow_parentheses.vim'
Plug 'https://github.com/reedes/vim-colors-pencil'
Plug 'https://github.com/Kjwon15/vim-transparent'
Plug 'https://github.com/editorconfig/editorconfig-vim'

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

" ----- vim-airline -----
let g:airline_powerline_fonts = 1
" let g:airline_powerline_fonts = 0
" let g:airline_symbols_ascii = 1
let g:airline#extensions#tabline#enabled = 1

" ----- ctrlp -----
" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_by_filename = 1

" ----- Rainbow parentheses -----
autocmd VimEnter * RainbowParenthesesToggle

" ----- Syntastic -----
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ----- Buffergator -----
let g:buffergator_display_regime = "parentdir"
let g:buffergator_sort_regime = "basename"
