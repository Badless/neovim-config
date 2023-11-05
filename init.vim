:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set smarttab

call plug#begin()

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
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
Plug 'alec-gibson/nvim-tetris'
Plug 'Saecki/crates.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'dense-analysis/ale'

set encoding=UTF-8

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

nnoremap <C-t> :ToggleTerm<CR>
nnoremap <C-r> :NvimTreeToggle<CR>
nnoremap <C-f> :Telescope<CR>

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

lua vim.notify = require('notify')

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['vimls'].setup {
    capabilities = capabilities
  }
EOF
