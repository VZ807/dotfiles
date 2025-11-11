return {
  {
    "uga-rosa/cmp-dictionary",
    config = function()
      local dict = require("cmp_dictionary")

      dict.setup({
        dic = {
          ['markdown'] = vim.fn.expand('~/.config/nvim/dictionary.txt'),
          ['text']     = vim.fn.expand('~/.config/nvim/dictionary.txt'),
        },
        first_case_insensitive = true,
        keyword_length = 2, -- start suggesting after 2 characters
      })
    end,
    ft = { "markdown", "text" },
  },
}

