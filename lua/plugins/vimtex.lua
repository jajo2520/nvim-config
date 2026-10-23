return {
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    -- === VimTeX Configuration ===
    vim.g.tex_flavor = 'latex'
    vim.g.vimtex_view_method = 'skim'   -- or 'skim' (macOS), 'okular', etc.
    vim.g.vimtex_view_skim_sync = 1
    vim.g.vimtex_view_skim_activate = 1
    vim.g.vimtex_quickfix_mode = 0

    vim.opt.conceallevel = 1
    vim.opt.concealcursor = "c"
    vim.g.tex_conceal = 'abdmg'


    vim.g.vimtex_compiler_method = 'latexmk'

    vim.g.vimtex_compiler_latexmk = {
      build_dir = '',
      callback = 1,
      continuous = 1,
      executable = 'latexmk',
      options = {
        '-pdf',
        '-interaction=nonstopmode',
        '-synctex=1',
      },
    }

    vim.g.vimtex_compiler_tectonic = {
        continuous = 1,
        callback = 1,
        build_dir = 'build',
        out_dir = '',
        options = {
            '--synctex',
            '--keep-logs',
            '--keep-intermediates',  -- keep aux files (optional)
        },
    }

    vim.g.vimtex_compiler_silent = 1
    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_view_automatic = 0

  end
}
