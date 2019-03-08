" ******************************************************************************
" My default personal VIMRC
" Constantin Masson
" ******************************************************************************

syntax on " The first thing because some pluggin already need it


" ------------------------------------------------------------------------------
" PLUG (Plugins manager)
" ------------------------------------------------------------------------------

call plug#begin('~/.config/nvim/plugged')

" Syntax / Theme
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/nanotech/jellybeans.vim'
Plug 'https://github.com/tomasr/molokai'
Plug 'https://github.com/altercation/solarized'
Plug 'https://github.com/chriskempson/tomorrow-theme'
Plug 'https://github.com/tikhomirov/vim-glsl'
Plug 'https://github.com/kien/rainbow_parentheses.vim'
Plug 'https://github.com/pboettch/vim-cmake-syntax'

" Project management
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'https://github.com/jeetsukumaran/vim-buffergator'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/airblade/vim-gitgutter'

" Code help (Indent / completion...)
Plug 'https://github.com/editorconfig/editorconfig-vim'
Plug 'https://github.com/Valloric/YouCompleteMe', {'for' : ['c', 'cpp'], 'do' : './install.py --clang-completer --system-libclang'}
" Plug 'https://github.com/vim-syntastic/syntastic'

" Misc
Plug 'https://github.com/JamshedVesuna/vim-markdown-preview'
" Plug 'https://github.com/iamcco/markdown-preview.nvim'
" Plug 'https://github.com/vim-latex/vim-latex'

" TODO
" Plug 'https://github.com/plasticboy/vim-markdown'
" Plug 'https://github.com/junegunn/vim-easy-align'
" Plug 'https://github.com/reedes/vim-colors-pencil'

call plug#end()


" ------------------------------------------------------------------------------
" Plugins configurations
" ------------------------------------------------------------------------------

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline_powerline_fonts = 0     " Use ASCII instead
" let g:airline_symbols_ascii = 1       " Use ASCII instead

" ctrlp
" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_by_filename = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Rainbow parentheses
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadBraces
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Syntastic CPP
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_config_file = ".syntastic_cpp_config"
let g:syntastic_cpp_include_dirs = [ 'includes', 'headers' ]
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_quiet_messages = {"regex" : '.*pragma once in main file'}

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

" Ladder - General settings
nnoremap <leader>vo :vsplit $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>

" Ladder - Spell settings
nnoremap <leader>sf :setlocal spelllang=CA_fr<CR>
nnoremap <leader>se :set spelllang=CA_en<CR>

" Ladder - Editing
nnoremap <leader>u viwU
nnoremap <leader>c <s-I>/*<esc><s-a>*/<esc>
nnoremap <leader>a :set paste<CR>
nnoremap <leader>aa :set nopaste<CR>

" Ladder - Mics
nnoremap <leader>b :ls<CR>:buffer<SPACE>
nnoremap <leader>gg :vimgrep //gj ./**/*.

" F1 - F12 Keys
nnoremap <F2> :set spell<CR>
nnoremap <F3> :set nospell<CR>
nnoremap <F4> :SyntasticToggleMode<CR>
nnoremap <F7> :NERDTreeToggle<CR>
nnoremap <F8> :BuffergatorToggle<CR>
nnoremap <F9> :TagbarToggle<CR>

" Mouse
noremap <RightMouse>        <Nop>
noremap <2-RightMouse>      <Nop>
noremap <3-RightMouse>      <Nop>
noremap <4-RightMouse>      <Nop>

noremap <LeftMouse>         <Nop>
noremap <2-LeftMouse>       <Nop>
noremap <3-LeftMouse>       <Nop>
noremap <4-LeftMouse>       <Nop>


" ------------------------------------------------------------------------------
" General Editor Settings
" ------------------------------------------------------------------------------

" Syntax and theme
colorscheme jellybeans
highlight SpecialKey ctermbg=none
highlight SpellBad ctermbg=none
highlight SpellBad ctermfg=Red
highlight ColorColumn ctermbg=Black ctermfg=Red

" General editor configs
set listchars=trail:.,tab:>-,nbsp:~,extends:>,precedes:<
set list                " Display special char
set number              " Display line number
set ruler               " Display line and column cursor
set mouse=a             " Enable mouse in all modes
set cursorline          " Hightlight current cursor line
set laststatus=2        " Always display status line
set magic
set ignorecase          " Ignore uppercase
set incsearch           " Show matches while typing
set hlsearch            " Hightlight previous search
set splitbelow
set wildmenu
set showmatch           " Show matching brace when insert one
set matchtime=1         " Speed up brace matching time

" Tab / Text size / Ruler
set shiftwidth=4        " Tab size
set tabstop=4           " Tab size
set expandtab           " Insert space instead of tab
set smarttab            " Tab in front of a line insert blanck
set textwidth=0         " Unlimited text width
set nowrap              " Don't wrap text if reach screen size
set colorcolumn=81      " 80 Char ruler

" Coding / Completion / Indent / Format
set autoindent          " Copy indent from current line when new line
set breakindent         " Wrapped line indented
set smartindent         " Smart autoindent when new line
set omnifunc=syntaxcomplete#Complete

" Misc
set noswapfile          " No swapfile
set nobackup            " No backup file
set lazyredraw          " Speedup maccro execution (Don't redraw while exec)
set autochdir           " vim cd in opened file / buffer etc
filetype plugin on      " Enable filetype and plugin detection
filetype indent on      " Enable filetype and indent detection
