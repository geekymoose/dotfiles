" ******************************************************************************
" MAPS / SHORTCUTS / KEY BINDINGS
" ******************************************************************************
" (n:normal / i:insert / v:visual+select / x:visual / s:select / c:cmd / o:op)
"
" :nnoremap - Display normal mode maps
" :inoremap - Display insert mode maps
" :vnoremap - Display visual and select mode maps
" :snoremap - Display select mode maps
" :xnoremap - Display visual mode maps
" :cnoremap - Display command-line mode maps
" :onoremap - Display operator pending mode maps
" ******************************************************************************
let mapleader = "-"

" General settings
nnoremap <leader>vo :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>

" Spell settings
nnoremap <leader>sf :setlocal spelllang=CA_fr<cr>
nnoremap <leader>se :set spelllang=CA_en<cr>

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
nnoremap <leader>i viwU
nnoremap <leader>c <s-I>/*<esc><s-a>*/<esc>
nnoremap <leader>a :set paste<cr>
nnoremap <leader>aa :set nopaste<cr>

" Mics
nnoremap <leader>b :ls<cr>:buffer<Space>
nnoremap <leader>gg :vimgrep //gj ./**/*.
