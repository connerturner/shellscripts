-- Init.lua

local Plug = vim.fn['plug#']

vim.cmd [[
    set number
    set mouse=a
    set autoindent
    set shiftwidth=4
    set tabstop=4
    set nosmd
]]

vim.cmd [[
    set background=dark
    set ruler
    set laststatus=2
    set wildmenu
    map q <Nop>
    set splitbelow
    set tgc
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
    Plug 'arcticicestudio/nord-vim'
    Plug 'lambdalisue/fern.vim'
    Plug 'feline-nvim/feline.nvim'
vim.call('plug#end')

-- Feline Status bar config
require('feline').setup({preset='noicion'})

-- Map Fern toggle to Leader F
vim.api.nvim_set_keymap('n', '<Leader>f', ':Fern . -drawer -width=35 -reveal=% -toggle<CR><C-w>=', { noremap=true,silent=true })

