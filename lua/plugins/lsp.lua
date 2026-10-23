return {
  -- 1. Core LSP config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- ensure cmp_nvim_lsp loads first
    },
    config = function()
      local lspconfig = require("lspconfig")
      -- 👇 load cmp capabilities first
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Example LSP setup
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({ capabilities = capabilities})

      lspconfig.clangd.setup({  capabilities = capabilities,
                                cmd = { "clangd", "--compile-commands-dir=build" },})

      -- LaTeX (TexLab)
      lspconfig.texlab.setup({
        autostart = false,
        capabilities = capabilities,
        settings = {
          texlab = {
            build = {
              executable = "latexmk",
              args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
              onSave = true, -- auto-build on save
            },
            forwardSearch = {
              executable = "open", -- macOS default PDF viewer (Obsidian)
            },
            chktex = {
                onOpenAndSave = false,
                onEdit = false,
            },
          },
        },
      })


      -- Grammar checker (LTeX)
      --lspconfig.ltex.setup({
       -- capabilities = capabilities,
        --settings = { ltex = { language = "en-US" } },
     -- })
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
          "hls",
          "texlab",
        },
        automatic_installation = true,
      })
    end,
  },
}

