return {
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    -- enabled = vim.fn.has "nvim-0.10" == 1,
    -- enabled = false,
    config = function()
      local neocodeium = require "neocodeium"
      neocodeium.setup()
      vim.keymap.set("i", "<A-f>", neocodeium.accept)
      vim.keymap.set("i", "<A-w>", function() require("neocodeium").accept_word() end)
      vim.keymap.set("i", "<A-l>", function() require("neocodeium").accept_line() end)
      vim.keymap.set("i", "<A-j>", function() require("neocodeium").cycle_or_complete() end)
      vim.keymap.set("i", "<A-k>", function() require("neocodeium").cycle_or_complete(-1) end)
      vim.keymap.set("i", "<A-x>", function() require("neocodeium").clear() end)
    end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    enabled = false,
    event = "VeryLazy",
    config = function()
      require("supermaven-nvim").setup {
        keymaps = {
          accept_suggestion = "<M-f>",
          clear_suggestion = "<C-]>",
          accept_word = "<M-w>",
        },
      }
    end,
  },
}
