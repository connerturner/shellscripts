set number
set background=dark
set ruler
set laststatus=2
set wildmenu
set termwinsize=16x0
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
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
