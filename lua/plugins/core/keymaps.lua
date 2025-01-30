-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        ["<Leader>c"] = false,
        ["<Leader>C"] = false,
        ["<Leader>fo"] = false,
        ["<Leader>fr"] = { ":Telescope oldfiles<cr>" },
        ["<Leader>q"] = { ":quit<cr>" },
        ["<Leader><Space>"] = { ":Telescope buffers<cr>" },
        ["Q"] = { function() require("astrocore.buffer").close() end, desc = "Close Buffer" },
        ["W"] = { "<cmd>w<cr>", desc = "Write" },
        ["vv"] = { "V", desc = "Visual mode" },
        ["ss"] = { ":split<CR>", desc = "Split horizontal" },
        ["sv"] = { ":vsplit<CR>", desc = "Split vertical" },
        ["sh"] = { "<C-w>h", desc = "Move Win left" },
        ["sj"] = { "<C-w>j", desc = "Move Win down" },
        ["sk"] = { "<C-w>k", desc = "Move Win up" },
        ["sl"] = { "<C-w>l", desc = "Move Win right" },
        ["<Esc>"] = { ":nohlsearch<Bar>:echo<CR>", desc = "Cancel search highlighting" },
        ["<A-1>"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "ToggleTerm horizontal split" },
        ["<A-2>"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" },
        ["<A-4>"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "ToggleTerm vertical split" },
        ["<Tab>"] = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        ["<S-Tab>"] = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },
        ["<C-m>"] = { "<C-i>", desc = "Jumplist" },
        ["<C-j>"] = { function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" },

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
        ["<C-a>"] = { "gg<S-v>G", desc = "Select All" },
        ["<leader>x"] = { name = "Diagnostics" },
        ["<leader>xc"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Actions" },
        ["<leader>xx"] = { "<cmd>Telescope diagnostics <cr>", desc = "Diagnostics" },
        ["<leader>r"] = { name = "Refactor" },
        ["<leader>t"] = { name = "Test" },
        ["<leader>T"] = { name = "Telescope" },
        ["<leader>z"] = { name = "System" },
        ["<leader>zs"] = { "<cmd>e $MYVIMRC<cr>", desc = "Config" },
        ["<leader>zh"] = { "<cmd>checkhealth<cr>", desc = "Health" },
        ["<leader>zn"] = { "<cmd>Telescope notify<cr>", desc = "Notifications" },
        ["<leader>zm"] = { "<cmd>Mason<cr>", desc = "Mason" },
        ["<leader>fp"] = { "<cmd>Telescope projects<cr>", desc = "Projects" },
      },
      t = {
        ["<A-1>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
        ["<A-2>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
        ["<A-4>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
      v = {
        ["<"] = { "<gv", desc = "Stay in indent mode" },
        [">"] = { ">gv", desc = "Stay in indent mode" },
        ["p"] = { '"_dP', desc = "Dont yank in visual paste" },
      },
      x = {
        ["p"] = { '"_dP', desc = "Dont yank in visual paste" },
      },
    },
  },
}
