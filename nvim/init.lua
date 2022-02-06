-- All them plugins

require('packer').startup(function(use)
    use 'folke/lsp-colors.nvim'
    use 'wbthomason/packer.nvim'
    use 'preservim/nerdtree'
    use 'shaunsingh/nord.nvim'
    use 'voldikss/vim-floaterm'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'ryanoasis/vim-devicons'
    use 'L3MON4D3/LuaSnip'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- Lua
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
          require("trouble").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
          }
        end
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    
end)

-- lualine

require('lualine').setup{options = { theme = 'nord'}}


-- Basic config

vim.g.mapleader = ' '
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
vim.cmd('set clipboard+=unnamedplus')

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

-- Insert mode panic save

vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>", {noremap=false})

-- Trouble keymaps

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<CR>",
    {silent=true, noremap=false})
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>",
    {silent=true, noremap=false})
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<CR>",
    {silent=true, noremap=false})

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
            require('luasnip').lsp_expand(args.body)
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
        { name = 'luasnip' }, -- For vsnip users.
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
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'    

if not lspconfig.emmet_ls then    
  configs.emmet_ls = {    
    default_config = {    
      cmd = {'emmet-ls', '--stdio'};
      filetypes = {'html', 'css', 'blade'};
      root_dir = function(fname)    
        return vim.loop.cwd()
      end;    
      settings = {};    
    };    
  }    
end

local servers = {'pyright', 'intelephense', 'tsserver', 'emmet_ls'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities
  }
end


require'lspconfig'.html.setup {
  capabilities = capabilities,
}


require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  -- ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}



vim.cmd('autocmd CursorMoved * :lua vim.diagnostic.open_float()')



-- colorscheme

-- Example config in lua
vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = false
vim.g.nord_italic = true

-- Load the colorscheme
require('nord').set()
