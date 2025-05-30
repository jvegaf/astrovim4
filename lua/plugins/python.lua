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
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    ft = { "python" },
    branch = "regexp",
    config = function()
      require("venv-selector").setup {
        -- Your options go here
        -- name = "venv",
        -- auto_refresh = false
      }
    end,
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { "<leader>vs", "<cmd>VenvSelect<cr>" },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
    },
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
