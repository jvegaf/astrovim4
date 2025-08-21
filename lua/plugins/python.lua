local keys = require "lazy.core.handler.keys"
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.python-ruff" },
  {
    enabled = false,
    event = "VeryLazy",
    "jim-at-jibba/micropython.nvim",
    dependencies = { "akinsho/toggleterm.nvim", "stevearc/dressing.nvim" },
    config = function() vim.keymap.set("n", "<leader>mr", require("micropython_nvim").run) end,
  },
  {
    "stevanmilic/nvim-lspimport",
    ft = { "python" },
    event = "VeryLazy",
    keys = { { "<leader>I", "<cmd>lua require('lspimport').import()<cr>" } },
  },
  {
    "neolooong/whichpy.nvim",
    ft = { "python" },
    opts = {},
    keys = {
      { "<leader>lw", "<cmd>WhichPy select<cr>" },
    },
  },
  {
    "alexpasmantier/pymple.nvim",
    enabled = false,
    -- ft = { "python" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- optional (nicer ui)
      "stevearc/dressing.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    build = ":PympleBuild",
    opts = function() require("pymple").setup {} end,
  },
}
