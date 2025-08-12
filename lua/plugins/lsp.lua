return {
  -- 1. Core LSP config
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Example LSP setup (add more as needed)
      lspconfig.lua_ls.setup({})
      lspconfig.pyright.setup({})
      lspconfig.clangd.setup({})
    end,
  },

  -- 2. Mason (tool manager)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- 3. Mason bridge for LSPConfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "clangd",
        },
        automatic_installation = true,
      })
    end,
  },
}

