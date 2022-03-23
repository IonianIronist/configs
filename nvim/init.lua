-- All them plugins
require('packer').startup(function(use)
    use 'folke/lsp-colors.nvim'
    use 'wbthomason/packer.nvim'
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
    use 'simrat39/rust-tools.nvim'
    use 'romainl/vim-cool'
    use 'airblade/vim-gitgutter'
    use 'onsails/lspkind-nvim'
    use 'preservim/nerdtree'
    use 'ThePrimeagen/harpoon'
    use { 'alvarosevilla95/luatab.nvim', requires='kyazdani42/nvim-web-devicons' }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require("trouble").setup {} end
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'windwp/nvim-autopairs'
end)

-- lualine

require('lualine').setup{options = { theme = 'nord'}}

require('nvim-autopairs').setup{}
require('luatab').setup {}
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

-- Harpoon

vim.api.nvim_set_keymap("n", "<Leader>m", ":lua require('harpoon.mark').add_file()<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Leader>v", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Leader>a", ":lua require('harpoon.ui').nav_file(1)<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Leader>s", ":lua require('harpoon.ui').nav_file(2)<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Leader>d", ":lua require('harpoon.ui').nav_file(3)<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Leader>u", ":lua require('harpoon.ui').nav_file(4)<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Leader>i", ":lua require('harpoon.ui').nav_file(5)<CR>", {noremap=true})

-- Window movement

vim.api.nvim_set_keymap("n", "<Leader>h", "<C-w><C-h>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Leader>j", "<C-w><C-j>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Leader>k", "<C-w><C-k>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Leader>l", "<C-w><C-l>", {noremap=true})

-- nvim-tree

vim.api.nvim_set_keymap("n", "<Leader>t", ":NERDTreeToggle<CR>", {noremap=true})

-- Tab movement

vim.api.nvim_set_keymap("n", "tn", ":tabnew<CR>", {noremap=true})
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
vim.g.floaterm_keymap_toggle = '<F7>'
vim.g.floaterm_keymap_next = '<F8>'
vim.g.floaterm_keymap_new = '<F9>'
vim.g.floaterm_keymap_kill = '<F10>'

-- Telescope bindings

vim.api.nvim_set_keymap("n", "ff", ":lua require('telescope.builtin').find_files()<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "fg", ":lua require('telescope.builtin').live_grep()<CR>", {noremap=true})

-- Lsp, autocomplete, snippets

require('lspconfig').pyright.setup{}

vim.cmd('set completeopt=menu,menuone,noselect')
-- Setup nvim-cmp.
local cmp = require'cmp'
local lspkind = require('lspkind')
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
    }),
    formatting = {format = lspkind.cmp_format(),},

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

-- Setup lsp.
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

require('rust-tools').setup({})

--vim.cmd('autocmd CursorMoved * :lua vim.diagnostic.open_float()')



-- colorscheme

-- Example config in lua
vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = false
vim.g.nord_italic = true

-- Load the colorscheme
require('nord').set()



-- RUST

local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)


