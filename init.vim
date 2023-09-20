:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set smarttab

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'feline-nvim/feline.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'folke/tokyonight.nvim'
Plug 'm4xshen/autoclose.nvim'
Plug 'sbdchd/neoformat'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvimdev/dashboard-nvim'
Plug 'akinsho/toggleterm.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'folke/trouble.nvim'
Plug 'andweeb/presence.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'ThePrimeagen/vim-be-good'
Plug 'alec-gibson/nvim-tetris'
Plug 'Saecki/crates.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'dense-analysis/ale'

set encoding=UTF-8
set guifont=Jetbrains\ Mono\ Nerd\ Font:h10

call plug#end()

:colorscheme tokyonight-night

lua require('feline').setup()
lua require('gitsigns').setup()
lua require('nvim-tree').setup()
lua require('autoclose').setup()
lua require('dashboard').setup()
lua require('toggleterm').setup()
lua require('crates').setup()
lua require('trouble').setup()

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
nnoremap <C-t> :ToggleTerm<CR>
nnoremap <C-r> :NvimTreeToggle<CR>
nnoremap <C-f> :Telescope<CR>

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

lua vim.notify = require('notify')
