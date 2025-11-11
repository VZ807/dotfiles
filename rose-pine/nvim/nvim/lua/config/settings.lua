-----------NVIM Settings----------
-- Enable relative line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Set tab width to 4 spaces
vim.opt.tabstop = 4      -- number of visual spaces per TAB
vim.opt.shiftwidth = 4   -- number of spaces for each indentation
vim.opt.expandtab = true -- convert tabs to spaces

-- Yank to system clipboard with <leader>y in normal and visual modes
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { noremap = true, silent = true })

-- Optional: <leader>Y yanks whole line
vim.keymap.set('n', '<leader>Y', '"+yy', { noremap = true, silent = true })

vim.o.scrolloff = 5

vim.env.CLANGD_FLAGS = "--fallback-style=file"

vim.opt.hlsearch = false   -- don't highlight search matches
vim.opt.incsearch = true   -- optional: show matches as you type

-----------Mason & nvimcmp(lsp)----------
-- ===============================
-- Mason Setup
-- ===============================
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "ltex" }, -- add other servers here if needed
    automatic_enable = true,       -- automatically enable installed servers
})

-- ===============================
-- nvim-cmp Setup
-- ===============================
local cmp = require("cmp")
local luasnip = require("luasnip")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-J>"] = cmp.mapping.select_next_item(),
        ["<C-K>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
})

-- ===============================
-- LSP Configuration (New API)
-- ===============================
-- Configure LTEX
vim.lsp.config("ltex", {
    capabilities = capabilities,
    settings = {
        ltex = {
            language = "en-US",
        }
    },
    filetypes = { "text", "markdown" }, -- add more filetypes if needed
})
vim.lsp.enable("ltex")

-- ===============================
-- Diagnostics Configuration
-- ===============================
vim.diagnostic.config({
    virtual_text = {
        prefix = "●",  -- could be "■", "▎", "●", "", etc.
        spacing = 2,
        source = "if_many", -- show source only if multiple
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})




-----------Treesitter----------
require 'nvim-treesitter.configs'.setup {
    ensure_installed = {}, -- Install maintained parsers, including for C++
    auto_install = true,
    highlight = {
        enable = true,                             -- Enable syntax highlighting
        additional_vim_regex_highlighting = false, -- Disable Vim's regex-based highlighting
    },
    indent = {
        enable = true, -- Enable indentation based on Tree-sitter
    },
}

-----------Telescope----------
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
