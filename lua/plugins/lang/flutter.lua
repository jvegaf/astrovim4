return {
  {
    "akinsho/pubspec-assist.nvim",
    dependencies = { "plenary.nvim" },
    event = "VeryLazy",
    config = function() require("pubspec-assist").setup() end,
  },
}
