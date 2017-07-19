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
set spell
set mouse=a
set cursorline

" Coding
set nowrap
set autoindent
set expandtab " Use space instead of tabs
set tabstop=4
set shiftwidth=4

set incsearch
set splitbelow
set splitright

" Syntax and theme
syntax on
syntax enable
set background=dark
colorscheme jellybeans
highlight ColorColumn ctermbg=1
highlight Normal ctermbg=none
highlight NonText ctermbg=none

" misc
set noswapfile
set nobackup


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
