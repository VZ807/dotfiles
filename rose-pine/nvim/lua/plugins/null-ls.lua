return {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls.nvim", -- ✅ This is the maintained null-ls
    },
    config = function()
        -- Import none-ls (null-ls fork)
        local null_ls = require("null-ls")

        -- Create augroup for formatting
        local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

        -- Setup null-ls with on_attach
        null_ls.setup({
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    -- Clear old autocmds for this buffer
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

                    -- Format before save
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end,
        })

        -- Setup mason-null-ls
        require("mason-null-ls").setup({
            ensure_installed = {"prettierd"}, -- will auto-install prettier if not present
            automatic_installation = true,     -- auto-install anything you use
            handlers = {},                     -- use default handlers
        })
    end,
}
