-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = true },

  { "nvim-neotest/nvim-nio" },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "cappyzawa/trim.nvim",
    event = "BufWrite",
    opts = {
      trim_on_write = true,
      trim_trailing = true,
      trim_last_line = false,
      trim_first_line = false,
      -- ft_blocklist = { "markdown", "text", "org", "tex", "asciidoc", "rst" },
      -- patterns = {[[%s/\(\n\n\)\n\+/\1/]]}, -- Only one consecutive bl
    },
  },
  ------------------------------------------------------------------------------
  -- Find And Replace
  {
    "MagicDuck/grug-far.nvim",
    event = "VeryLazy",
    cmd = { "GrugFar" },
    opts = {
      keymaps = {
        replace = "<C-[>",
        qflist = "<C-q>",
        gotoLocation = "<enter>",
        close = "<C-x>",
      },
    },
  },
  ------------------------------------------------------------------------------
  -- Utilities {{{2
  ------------------------------------------------------------------------------
  {
    -- https://github.com/LunarVim/bigfile.nvim
    "LunarVim/bigfile.nvim",
    event = "BufReadPre",
    opts = {
      filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
    },
    config = function(_, opts) require("bigfile").setup(opts) end,
  },
  { "will133/vim-dirdiff", cmd = { "DirDiff" } },
  {
    "AndrewRadev/linediff.vim",
    cmd = "Linediff",
    keys = {
      { "<localleader>lL", "<cmd>Linediff<CR>", desc = "linediff: toggle" },
    },
  },
  {
    "axieax/urlview.nvim",
    cmd = { "UrlView" },
    keys = {
      { "<leader>bu", "<cmd>UrlView buffer<cr>", desc = "urlview: buffers" },
      { "<leader>zu", "<cmd>UrlView lazy<cr>", desc = "urlview: lazy" },
      {
        "<leader>bU",
        "<cmd>UrlView buffer action=clipboard<cr>",
        desc = "urlview: copy links",
      },
    },
    opts = {
      default_title = "Links:",
      default_picker = "native",
      default_prefix = "https://",
      default_action = "system",
    },
  },
  {
    "chrisgrieser/nvim-genghis",
    dependencies = "stevearc/dressing.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local g = require "genghis"
      map("n", "<localleader>fp", g.copyFilepath, { desc = "genghis: yank filepath" })
      map("n", "<localleader>fn", g.copyFilename, { desc = "genghis: yank filename" })
      map("n", "<localleader>fr", g.renameFile, { desc = "genghis: rename file" })
      map("n", "<localleader>fm", g.moveAndRenameFile, { desc = "genghis: move and rename" })
      map("n", "<localleader>fc", g.createNewFile, { desc = "genghis: create new file" })
      map("n", "<localleader>fd", g.duplicateFile, { desc = "genghis: duplicate current file" })
    end,
  },
  {
    "luckasRanarison/nvim-devdocs",
    -- stylua: ignore
    keys = {
      { '<leader>vf', '<cmd>DevdocsOpenFloat<CR>', desc = 'devdocs: open float', },
      { '<leader>vb', '<cmd>DevdocsOpen<CR>', desc = 'devdocs: open in buffer', },
      { '<leader>vo', '<cmd>DevdocsOpenFloat ', desc = 'devdocs: open documentation', },
      { '<leader>vi', '<cmd>DevdocsInstall ', desc = 'devdocs: install' },
      { '<leader>vu', '<cmd>DevdocsUninstall ', desc = 'devdocs: uninstall' },
    },
    opts = {
      -- stylua: ignore
      ensure_installed = {
        'git', 'bash', 'lua-5.4', 'html', 'css', 'javascript', 'typescript',
        'react', 'java', 'electron', 'dart', 'kotlin', 'yarn', 'sqlite',
        'spring_boot', 'docker', 'eslint',
      },
      wrap = true,
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- }}}
  --------------------------------------------------------------------------------
  -- Share Code
  { "TobinPalmer/rayso.nvim", cmd = { "Rayso" }, opts = {} },
  {
    "ethanholz/freeze.nvim",
    cmd = "Freeze",
    opts = {},
    keys = {
      { "<leader>F", ":Freeze<cr>", mode = { "v" }, desc = "Freeze Code" },
    },
  },
}
