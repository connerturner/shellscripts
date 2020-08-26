set number
set background=dark
set ruler
set laststatus=2
set wildmenu
map q <Nop>

set tabstop =4
set softtabstop =4
set shiftwidth =4
set expandtab

" vim-plugins
if filereadable(expand("~/.vimrc.plug"))
    source ~/.vimrc.plug
endif
nmap oo o<Esc>k
