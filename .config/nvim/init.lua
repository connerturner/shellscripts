-- Init.lua

local Plug = vim.fn['plug#']

vim.cmd [[
    set number
    set mouse=a
    set autoindent
    set shiftwidth=4
    set tabstop=4
]]

vim.cmd [[
    set background=dark
    set ruler
    set laststatus=2
    set wildmenu
    map q <Nop>
    set splitbelow
]]

vim.cmd [[
    set softtabstop=4
    set expandtab
    set autochdir
]]

vim.cmd [[
    autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
    tnoremap <Esc><Esc> <C-w><S-n>
]]


vim.call('plug#begin')
    Plug 'lambdalisue/fern.vim'
vim.call('plug#end')
