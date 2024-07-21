return {
  "f-person/auto-dark-mode.nvim",
  lazy = false,
  enabled = true,
  config = {
    update_interval = 1000,
    set_dark_mode = function()
      -- vim.api.nvim_set_option("background", "dark")
      vim.cmd "colorscheme astrodark"
      -- vim.cmd("colorscheme dracula")
    end,
    set_light_mode = function()
      -- vim.api.nvim_set_option("background", "light")
      -- vim.cmd "colorscheme tokyonight-day"
      vim.cmd "colorscheme astrolight"
    end,
  },
}
