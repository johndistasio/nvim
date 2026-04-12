return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
        -- Required by Telescope.
        { 'nvim-lua/plenary.nvim' },

        -- Fuzzy finder sorter for Telescope written in C.
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

        -- Activate extenstions. This must happen after the setup function.
        require('telescope').load_extension('fzf')
        require('telescope').load_extension('ui-select')

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find buffers' })

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
        vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find current word' })

        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search Help' })
        vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = 'Search Telescope' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search Diagnostics' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
    end,
}
