---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.lsp.nvim-java" },
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      settings = {
        format = {
          enabled = true,
          settings = { -- you can use your preferred format style
            url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
            profile = "GoogleStyle",
          },
        },
      },
    },
  },
  {
    "simaxme/java.nvim",
    config = function() require("simaxme-java").setup() end,
  },
  {
    "oclay1st/gradle.nvim",
    cmd = { "Gradle", "GradleExec", "GradleInit" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("gradle").setup {
        -- options, see default configuration
      }
    end,
  },
  {
    "eatgrass/maven.nvim",
    cmd = { "Maven", "MavenExec" },
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("maven").setup {
        executable = "./mvnw",
      }
    end,
  },
  {
    "tobias-z/java-util.nvim",
    config = function()
      require("java_util").setup {}
      -- generate a user command for this features
      -- lsp.rename
      -- lsp.create_test
      -- lsp.goto_test
      vim.api.nvim_create_user_command(
        "JunitGoToTest",
        require("java_util.lsp").goto_test {
          on_no_results = function(opts)
            require("java_util.lsp").create_test()
            -- or require("java_util.lsp").create_test({ testname = string.format("%sTest", opts.current_class) }) if you don't want a popup to choose a name
          end,
        } {}
      )
      vim.api.nvim_create_user_command(
        "JunitFindAllTests",
        require("java_util.lsp").goto_test {
          current_class = "",
        } {}
      )
    end,
    ft = { "java" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "akinsho/toggleterm.nvim",
    },
  },
  {
    "tvntvn13/java-test-util.nvim",
    ft = { "java" },
    cmd = { "MvnRunMethod", "MvnRunClass", "MvnRunPackage", "MvnRunPrev", "MvnRunAll" },
    config = function() require("java_test_util").setup {} end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "akinsho/toggleterm.nvim",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "iomallach/telescope-gradle.nvim",
      "zerochae/telescope-spring.nvim",
    },
    event = "VeryLazy",
    opts = function()
      require("telescope").load_extension "gradle"
      require("telescope").load_extension "spring"
    end,
  },
}
