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
