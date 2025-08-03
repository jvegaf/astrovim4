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
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
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
        ["<Leader>C"] = false,
        ["<Leader>fo"] = false,

        ["<Leader>e"] = { "<cmd>NvimTreeFocus<cr>", desc = "NvimTree" },
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["Q"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
        ["<Leader>cu"] = { ":lua Snacks.picker.undo()<cr>" },
        ["<Leader>fr"] = { ":lua Snacks.picker.recent()<cr>" },
        ["<Leader>q"] = { ":quit<cr>" },
        ["<Leader><Space>"] = { ":lua Snacks.picker.files()<cr>" },
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
        ["L"] = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        ["H"] = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },
        ["<C-m>"] = { "<C-i>", desc = "Jumplist" },

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
        ["<leader>xc"] = { "<cmd>lua Snacks.picker.actions()<cr>", desc = "Code Actions" },
        ["<leader>xx"] = { "<cmd>lua Snacks.picker.diagnostics_buffer()<cr>", desc = "Diagnostics" },
        ["<leader>r"] = { name = "Refactor" },
        ["<leader>t"] = { name = "Terminal" },
        ["<leader>T"] = { name = "Telescope" },
        ["<leader>z"] = { name = "System" },
        ["<leader>zs"] = { "<cmd>e $MYVIMRC<cr>", desc = "Config" },
        ["<leader>zh"] = { "<cmd>checkhealth<cr>", desc = "Health" },
        ["<leader>zn"] = { "<cmd>lua Snacks.picker.notifications()<cr>", desc = "Notifications" },
        ["<leader>zm"] = { "<cmd>Mason<cr>", desc = "Mason" },
        ["<leader>zl"] = { "<cmd>Lazy<cr>", desc = "Lazy" },
        ["<leader>fp"] = { "<cmd>lua Snacks.picker.projects()<cr>", desc = "Projects" },
        ["<leader>ls"] = { "<cmd>AerialOpen<cr>", desc = "Aerial" },
        ["<M-j>"] = { ":m .+1<cr>==", desc = "move down" },
        ["<M-k>"] = { ":m .-2<cr>==", desc = "move up" },
        ["<leader>lS"] = { "<cmd>lua Snacks.picker.lsp_document_symbols<cr>", desc = "Aerial" },
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
        ["<M-j>"] = { ":m '>+1<cr>gv=gv", desc = "move down" },
        ["<M-k>"] = { ":m '<-2<cr>gv=gv", desc = "move up" },
      },
      x = {
        ["p"] = { '"_dP', desc = "Dont yank in visual paste" },
      },
    },
  },
}
