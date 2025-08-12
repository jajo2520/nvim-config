 return {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set('n', '<leader>fg', builtin.find_files, {})
        vim.keymap.set('n', '<leader>ff', builtin.live_grep, {})
     end}

 
