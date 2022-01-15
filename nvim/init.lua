-- All them plugins

require('packer').startup(function(use)
    use 'preservim/nerdtree'
    use 'morhetz/gruvbox'
    use 'voldikss/vim-floaterm'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/vim-vsnip'
    use 'ryanoasis/vim-devicons'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    
end)

-- Basic config

vim.g.mapleader = ' '
vim.g.airline_theme = 'deus'

local opt = vim.opt

opt.relativenumber         =          true
opt.termguicolors          =          true
opt.expandtab              =          true
opt.wildmenu               =          true 
opt.number                 =          true
opt.ruler                  =          true
opt.wrap                   =          false
opt.showcmd                =          true
opt.shiftwidth             =          4
opt.background             =          'dark' 
opt.scrolloff              =          7
opt.tabstop                =          4
opt.syntax                 =          'on'
opt.mouse                  =          'a'

vim.cmd('au TextYankPost * lua vim.highlight.on_yank {on_visual = false}')
vim.cmd('colorscheme gruvbox')
-- Window movement

vim.api.nvim_set_keymap("n", "<Leader>h", "<C-w><C-h>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Leader>j", "<C-w><C-j>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Leader>k", "<C-w><C-k>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Leader>l", "<C-w><C-l>", {noremap=true})


-- Open NERDTree

vim.api.nvim_set_keymap("n", "<Leader>t", ":NERDTree<CR>", {noremap=true})

-- Tab movement

vim.api.nvim_set_keymap("n", "tn", ":tabnew<CR>:NERDTree<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "th", ":tabprev<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "tl", ":tabnext<CR>", {noremap=true})

-- Fast escape

vim.api.nvim_set_keymap("i", "ii", "<Esc>", {noremap=true})

-- Normal panic save

vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>", {noremap=false})

-- Flying terminal, makes you kool

vim.g.floaterm_keymap_new = '<F7>'
vim.g.floaterm_keymap_kill = '<F8>'

-- Telescope bindings

vim.api.nvim_set_keymap("n", "ff", ":lua require('telescope.builtin').find_files()<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "fg", ":lua require('telescope.builtin').live_grep()<CR>", {noremap=true})

-- Lsp, autocomplete, snippets

require('lspconfig').pyright.setup{}

vim.cmd('set completeopt=menu,menuone,noselect')

-- Setup nvim-cmp.
  local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For vsnip users.
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify cmp.config.disable if you want to remove the default <C-y> mapping.
        ['<C-e>'] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set select to false to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for / (if you enabled native_menu, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled native_menu, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pyright'].setup {
    capabilities = capabilities
}
