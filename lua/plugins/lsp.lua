-- LSP setup using the native Neovim 0.11+ API (vim.lsp.config / vim.lsp.enable).
-- nvim-lspconfig supplies default server configs; vim.lsp.config() tweaks them.
return {
  -- 1. Server settings
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- Tell every server that nvim-cmp can handle completion snippets etc.
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      vim.lsp.config("clangd", {
        cmd = { "clangd", "--compile-commands-dir=build" },
      })

      -- LaTeX (TexLab). Not started automatically: run :LspStart texlab
      vim.lsp.config("texlab", {
        settings = {
          texlab = {
            build = {
              executable = "latexmk",
              args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
              onSave = true, -- auto-build on save
            },
            forwardSearch = {
              executable = "open", -- macOS default PDF viewer
            },
            chktex = {
              onOpenAndSave = false,
              onEdit = false,
            },
          },
        },
      })

      -- Grammar checker (LTeX)
      -- vim.lsp.config("ltex", { settings = { ltex = { language = "en-US" } } })
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

  -- 3. Mason bridge: installs the servers below and enables them
  --    automatically (mason-lspconfig v2 calls vim.lsp.enable for you).
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "clangd",
          "hls",
          "texlab",
        },
        -- keeps your old autostart = false for texlab
        automatic_enable = { exclude = { "texlab" } },
      })
    end,
  },
}
