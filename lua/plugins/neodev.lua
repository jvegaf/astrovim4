local function join_paths(...)
  local path_sep = vim.loop.os_uname().version:match "Windows" and "\\" or "/"
  local result = table.concat({ ... }, path_sep)
  return result
end

return {
  "folke/neodev.nvim",
  enabled = true,
  ft = "lua",
  opts = {
    debug = true,
    experimental = { pathStrict = true },
    library = {
      runtime = join_paths(vim.env.HOME, "neovim", "share", "nvim", "runtime"),
      plugins = { "nvim-dap-ui" },
      types = true,
    },
  },
}
