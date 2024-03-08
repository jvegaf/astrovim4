return {
  "Exafunction/codeium.vim",
  event = "InsertEnter",
  config = function()
    vim.g.codeium_disable_bindings = 1

    vim.keymap.set("i", "<A-l>", function() return vim.fn["codeium#Accept"]() end, { expr = true })
    vim.keymap.set("i", "<A-j>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
    vim.keymap.set("i", "<A-k>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
    vim.keymap.set("i", "<A-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
  end,
}
