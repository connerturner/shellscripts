set number
set mouse=a
set autoindent
set shiftwidth=4
set tabstop=4

set background=dark
set ruler
set laststatus=2
set wildmenu
map q <Nop>
set splitbelow

set softtabstop =4
set expandtab
set autochdir

autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
tnoremap <Esc><Esc> <C-w><S-n>


