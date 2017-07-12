" ******************************************************************************
" My default personal VIMRC
" Constantin Masson
" ******************************************************************************

" Import external files
source $HOME/.config/nvim/components/plugins.vim
source $HOME/.config/nvim/components/keys.vim
source $HOME/.config/nvim/components/ocaml.vim

" ******************************************************************************
" PERSONAL SETTINGS
" ******************************************************************************
set number
set colorcolumn=80
set list
set listchars=trail:.,tab:>-,nbsp:~,extends:>,precedes:<

set mouse=a
set nospell
set ruler
set nowrap
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set incsearch
set noswapfile

syntax on
syntax enable
set background=dark
colorscheme jellybeans


" Completion
" TODO To clean
function LOAD_OCAML()
    set omnifunc=merlin#Complete
    set completefunc=merlin#Complete
endfunction
augroup omnifuncs
    autocmd!
    autocmd FileType ocaml call LOAD_OCAML()
augroup end
