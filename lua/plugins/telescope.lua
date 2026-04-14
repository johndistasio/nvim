return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
        -- Required by Telescope.
        { 'nvim-lua/plenary.nvim' },

        -- Fuzzy finder for Telescope written in C.
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

        -- Use Telescope for selections instead of Neovim's rudimentary default ones.
        { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    config = function()
        require('telescope').setup({
            extensions = {
                ['ui-select'] = {
                    -- Show a centered selections list .
                    require('telescope.themes').get_dropdown(),
                },
            },
        })

        -- Activate extensions. This must happen after the setup function.
        require('telescope').load_extension('fzf')
        require('telescope').load_extension('ui-select')

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find buffers' })

        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search [f]iles' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search live [g]rep' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search current [w]ord' })

        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search [h]elp' })
        vim.keymap.set('n', '<leader>sT', builtin.builtin, { desc = 'Search [T]elescope' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search [d]iagnostics' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })

        vim.keymap.set('n', '<leader>st', '<cmd>TodoTelescope<cr>', { desc = 'Search [t]ODO' })
    end,
}
