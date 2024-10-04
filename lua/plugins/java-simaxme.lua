return {
  {
    "simaxme/java.nvim",
    config = function() require("simaxme-java").setup() end,
  },
  {
    "sledigabel/gradle.nvim",
    event = "VeryLazy",
  },
}
