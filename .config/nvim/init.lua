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
    Plug 'lambdalisue/fern-hijack.vim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug ('nvim-treesitter/nvim-treesitter')
vim.call('plug#end')

vim.g.mapleader = [[ ]]

vim.cmd('colorscheme nord')

-- Feline Status bar config
require('feline')--.setup({preset='noicion'})

-- BEGIN    Fern Config

-- Map Fern toggle to Leader F
vim.api.nvim_set_keymap('n', '<Leader>f', ':Fern . -drawer -width=35 -reveal=% -toggle<CR><C-w>=', { noremap=true,silent=true })
-- Enable hidden files to be shown
vim.g['fern#default_hidden'] = 1

-- END      Fern Config
-- BEGIN    Telescope Config
vim.api.nvim_set_keymap('n', '<Leader>gr','<cmd>Telescope live_grep<cr>', {noremap=true,silent=true})
vim.api.nvim_set_keymap('n', '<Leader>gf','<cmd>Telescope find_files<cr>', {noremap=true,silent=true})
