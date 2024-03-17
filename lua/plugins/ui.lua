return {
  {
    "folke/noice.nvim",
    dependencies = { "rcarriga/nvim-notify", "MunifTanjim/nui.nvim" },
    config = function()
      local focused = true
      require("noice").setup {
        lsp = {
          signature = {
            enabled = false,
          },
        },
        commands = {
          all = {
            -- options for the message history that you get with `:Noice`
            view = "split",
            opts = { enter = true, format = "details" },
            filter = {},
          },
        },
        routes = {
          {
            filter = {
              event = "notify",
              find = "No information available",
            },
            opts = { skip = true },
          },
          {
            filter = {
              cond = function() return not focused end,
            },
            view = "notify_send",
            opts = { stop = false },
          },
        },
        presets = {
          lsp_doc_border = true,
        },
      }

      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function() focused = true end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function() focused = false end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function() require("noice.text.markdown").keys(event.buf) end)
        end,
      })
    end,
  },
  {
    "zbirenbaum/neodim",
    enabled = false,
    event = "LspAttach",
    opts = {
      alpha = 0.75,
      blend_color = "#000000",
      update_in_insert = {
        enable = true,
        delay = 100,
      },
      hide = {
        virtual_text = true,
        signs = true,
        underline = true,
      },
    },
  },
}
