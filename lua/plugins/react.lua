return {
  "napmn/react-extract.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>rE",
      mode = { "v" },
      function() require("react-extract").extract_to_new_file() end,
      desc = "Extract component",
    },
  },
}
