vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wrap = true

vim.api.nvim_create_augroup("RememberFolds", { clear = true })
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = "RememberFolds",
  pattern = "*",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    local winconfig = vim.api.nvim_win_get_config(0)
    local is_floating = winconfig.relative ~= ""

    if bufname ~= "" and not is_floating then
      pcall(vim.cmd, "mkview")
    end
  end,
})

vim.api.nvim_create_autocmd("BufUnload", {
  pattern = "*.tex",
  callback = function()
    vim.cmd("VimtexClean")
  end,
})

-- Automatically start VimTeX compiler when opening a .tex file
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    -- Start compilation only if it's not already running
    vim.cmd("VimtexCompile")
  end,
})


vim.filetype.add({
    extension = {
        tpp = "cpp",
    },
})


vim.api.nvim_create_autocmd("BufWinEnter", {
  group = "RememberFolds",
  pattern = "*",
  command = "silent! loadview",
})
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

require("lazy").setup({import="plugins"},{import="plugins.lsp"})

vim.cmd([[
  augroup vimtex_autostop
    autocmd!
    autocmd VimLeavePre * VimtexStop
  augroup END
]])
