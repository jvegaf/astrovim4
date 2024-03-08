-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        ["<Leader>c"] = false,
        ["<Leader>fo"] = false,
        ["<Leader>fr"] = { ":Telescope oldfiles<cr>" },
        ["<Leader>q"] = { ":quit<cr>" },
        ["Q"] = { ":bwipeout<cr>", desc = "Close Buffer" },
        ["W"] = { "<cmd>w<cr>", desc = "Write" },
        ["vv"] = { "V", desc = "Visual mode" },
        ["<Tab>"] = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        ["<S-Tab>"] = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        ["<leader>cc"] = { "gg<S-v>G", desc = "Select All" },
        ["<leader>x"] = { name = "Diagnostics" },
        ["<leader>xc"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Actions" },
        ["<leader>xx"] = { "<cmd>Telescope diagnostics <cr>", desc = "Diagnostics" },
        ["<leader>r"] = { name = "Refactor" },
        ["<leader>t"] = { name = "Test" },
        ["<leader>T"] = { name = "Telescope" },
        ["<leader>z"] = { name = "System" },
        ["<leader>zc"] = { "<cmd>e $MYVIMRC<cr>", desc = "Config" },
        ["<leader>zh"] = { "<cmd>checkhealth<cr>", desc = "Health" },
        ["<leader>zn"] = { "<cmd>Telescope notify<cr>", desc = "Notifications" },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
  },
}
