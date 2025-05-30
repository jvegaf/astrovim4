local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("general", { clear = true })

-- Go to last loc when opening a buffer
autocmd("BufReadPre", {
  pattern = "*",
  callback = function()
    autocmd("FileType", {
      pattern = "<buffer>",
      once = true,
      callback = function()
        vim.cmd [[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]]
      end,
    })
  end,
})

autocmd("BufEnter", {
  callback = function() vim.opt.formatoptions:remove { "c", "r", "o" } end,
  group = "general",
  desc = "Disable New Line Comment",
})

-- autocmd("VimLeave", {
--   desc = "Stop running auto compiler",
--   group = augroup("autocomp", { clear = true }),
--   pattern = "*",
--   callback = function() vim.fn.jobstart { "autocomp", vim.fn.expand "%:p", "stop" } end,
-- })

autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function() vim.opt.conceallevel = 0 end,
})

autocmd("LspAttach", {
  group = augroup("lsp_attach_auto_diag", { clear = true }),
  callback = function(args)
    -- the buffer where the lsp attached
    ---@type number
    local buffer = args.buf

    -- create the autocmd to show diagnostics
    autocmd("CursorHold", {
      group = augroup("_auto_diag", { clear = true }),
      buffer = buffer,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = "rounded",
          source = "always",
          prefix = " ",
          scope = "cursor",
        }
        vim.diagnostic.open_float(nil, opts)
      end,
    })

    vim.keymap.set(
      "n",
      "gq",
      function() vim.lsp.buf.format(require("astrolsp").format_opts) end,
      { buffer = buffer, noremap = true, silent = true, desc = "Format buffer" }
    )
  end,
})
