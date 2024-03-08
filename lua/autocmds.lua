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

autocmd("VimLeave", {
  desc = "Stop running auto compiler",
  group = augroup("autocomp", { clear = true }),
  pattern = "*",
  callback = function() vim.fn.jobstart { "autocomp", vim.fn.expand "%:p", "stop" } end,
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

    vim.keymap.set("n", "gq", function()
      vim.lsp.buf.format {
        async = false,
        filter = function(attachedClient) return attachedClient.name == "null-ls" end,
      }
    end, { buffer = buffer, noremap = true, silent = true, desc = "Format buffer" })
  end,
})

-- nvim-tree

local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then return end

  -- create a new, empty buffer
  vim.cmd.enew()

  -- wipe the directory buffer
  vim.cmd.bw(data.buf)

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

autocmd({ "VimEnter" }, { callback = open_nvim_tree })
