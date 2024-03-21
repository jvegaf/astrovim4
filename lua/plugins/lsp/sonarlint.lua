return {
  { "mfussenegger/nvim-jdtls", lazy = true }, -- load jdtls on module
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      config = {
        sonarlint = function()
          return {
            cmd = {
              "sonarlint-language-server",
              -- Ensure that sonarlint-language-server uses stdio channel
              "-stdio",
              "-analyzers",
              -- paths to the analyzers you need, using those for python and java in this example
              vim.fn.expand "$MASON/share/sonarlint-analyzers/sonarpython.jar",
              vim.fn.expand "$MASON/share/sonarlint-analyzers/sonarcfamily.jar",
              vim.fn.expand "$MASON/share/sonarlint-analyzers/sonarjava.jar",
            },
            filetypes = {
              -- Tested and working
              "python",
              "cpp",
              "java",
            },
          }
        end,
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "sonarlint-language-server" },
    },
  },
}
