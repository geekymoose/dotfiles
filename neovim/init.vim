" ******************************************************************************
" My default personal VIMRC
" Constantin Masson
" ******************************************************************************

" Import external files
source $HOME/.config/nvim/components/plugins.vim
source $HOME/.config/nvim/components/keys.vim


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


" TODO: Should be in plugins but I don't know why it's not working
autocmd Syntax * RainbowParenthesesLoadBraces
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
