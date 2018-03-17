" ******************************************************************************
" My default personal VIMRC
" Constantin Masson
" ******************************************************************************


" ------------------------------------------------------------------------------
" PLUG (Plugins manager)
" ------------------------------------------------------------------------------

call plug#begin('~/.config/nvim/plugged')

Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/jeetsukumaran/vim-buffergator'
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'https://github.com/universal-ctags/ctags'
Plug 'https://github.com/plasticboy/vim-markdown'
Plug 'https://github.com/vim-latex/vim-latex'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'https://github.com/junegunn/vim-easy-align'
Plug 'https://github.com/kien/rainbow_parentheses.vim'
Plug 'https://github.com/reedes/vim-colors-pencil'
Plug 'https://github.com/Kjwon15/vim-transparent'
Plug 'https://github.com/editorconfig/editorconfig-vim'
Plug 'https://github.com/Valloric/YouCompleteMe', {'for' : ['c', 'cpp'], 'do' : './install.py --clang-completer --system-libclang'}
Plug 'https://github.com/tikhomirov/vim-glsl'

" Color scheme
Plug 'https://github.com/nanotech/jellybeans.vim'
Plug 'https://github.com/tomasr/molokai'
Plug 'https://github.com/chriskempson/tomorrow-theme'
Plug 'https://github.com/altercation/solarized'
Plug 'https://github.com/chriskempson/base16-vim'

call plug#end()


" ------------------------------------------------------------------------------
" Plugins configurations
" ------------------------------------------------------------------------------

" vim-airline
let g:airline_powerline_fonts = 1
" let g:airline_powerline_fonts = 0
" let g:airline_symbols_ascii = 1
let g:airline#extensions#tabline#enabled = 1

" ctrlp
" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_by_filename = 1

" Rainbow parentheses
autocmd VimEnter * RainbowParenthesesToggle

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Buffergator
let g:buffergator_display_regime = "parentdir"
let g:buffergator_sort_regime = "basename"



" ------------------------------------------------------------------------------
" MAPS / SHORTCUTS / KEY BINDINGS
" ------------------------------------------------------------------------------
" (n:normal / i:insert / v:visual+select / x:visual / s:select / c:cmd / o:op)
"
" :nnoremap - Display normal mode maps
" :inoremap - Display insert mode maps
" :vnoremap - Display visual and select mode maps
" :snoremap - Display select mode maps
" :xnoremap - Display visual mode maps
" :cnoremap - Display command-line mode maps
" :onoremap - Display operator pending mode maps
" ------------------------------------------------------------------------------

let mapleader = "-"

" General settings
nnoremap <leader>vo :vsplit $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>

" Spell settings
nnoremap <leader>sf :setlocal spelllang=CA_fr<CR>
nnoremap <leader>se :set spelllang=CA_en<CR>
nnoremap <F2> :set spell<CR>
nnoremap <F3> :set nospell<CR>

" Mouse
noremap <RightMouse>        <Nop>
noremap <2-RightMouse>      <Nop>
noremap <3-RightMouse>      <Nop>
noremap <4-RightMouse>      <Nop>

noremap <LeftMouse>         <Nop>
noremap <2-LeftMouse>       <Nop>
noremap <3-LeftMouse>       <Nop>
noremap <4-LeftMouse>       <Nop>

" Editing
nnoremap <leader>u viwU
nnoremap <leader>c <s-I>/*<esc><s-a>*/<esc>
nnoremap <leader>a :set paste<CR>
nnoremap <leader>aa :set nopaste<CR>

" Mics
nnoremap <leader>b :ls<CR>:buffer<SPACE>
nnoremap <leader>gg :vimgrep //gj ./**/*.


" ------------------------------------------------------------------------------
" Plugins key bindings
" ------------------------------------------------------------------------------
nnoremap <F8> :TagbarToggle<CR>
nnoremap <F7> :NERDTreeToggle<CR>
nnoremap <F9> :BuffergatorToggle<CR>


" ------------------------------------------------------------------------------
" General Editor Settings
" ------------------------------------------------------------------------------

" Editor theme
set number
set colorcolumn=81
set listchars=trail:.,tab:>-,nbsp:~,extends:>,precedes:<
set list
set ruler
set mouse=a
set cursorline
set laststatus=2
set magic
set ignorecase
set incsearch
set hlsearch
set splitbelow
set wildmenu

" Coding
set nowrap
set autoindent
set smartindent
set smarttab
set breakindent
set expandtab " Use space instead of tabs
set tabstop=4
set shiftwidth=4
set omnifunc=syntaxcomplete#Complete

" Syntax and theme
"set t_Co=256
syntax on
set background=dark
colorscheme jellybeans
highlight ColorColumn ctermbg=Red
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight SpecialKey ctermbg=none
highlight SpellBad ctermbg=none
highlight SpellBad ctermfg=Red

" misc
set noswapfile
set nobackup
set encoding=utf8
set lazyredraw
filetype plugin on
filetype indent on


" ------------------------------------------------------------------------------
" Conditional settings
" ------------------------------------------------------------------------------
function LOAD_OCAML()
    source $HOME/.config/nvim/components/ocaml.vim
endfunction

" Load some settings according to specific filetype
augroup conditional_settings
    autocmd!
    autocmd FileType ocaml call LOAD_OCAML()
augroup end

" Plugin specific
autocmd Syntax * RainbowParenthesesLoadBraces
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare

" Specific / tmp functions
function Link_img()
    exec '%s/\(<img.*src="\(.*\)".*>\)/<a href="\2">\1<\/a>/gc'
endfunction
