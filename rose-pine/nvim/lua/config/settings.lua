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


-----------Mason & nvimcmp(lsp)----------
require("mason").setup()
require("mason-lspconfig").setup()

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()


local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-J"] = cmp.mapping.select_next_item(),
        ["<C-K"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- if you want snippets
        { name = "buffer" },
        { name = "path" },
    }),
})

vim.diagnostic.config({
    virtual_text = {
        prefix = "●", -- could be "■", "▎", "●", "", etc.
        spacing = 2,
        source = "if_many", -- show "pyright" only if multiple sources
    },
    signs = true,
    underline = true,
    update_in_insert = false, -- prevents showing while typing
    severity_sort = true,
})


-- This will autoformat before writing any buffer
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
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
