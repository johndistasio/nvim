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

        -- Set keymaps.
        local wk = require('which-key')
        local builtin = require('telescope.builtin')

        wk.add({ '<leader><leader>', builtin.buffers, desc = 'Find buffers' })

        wk.add({
            { '<leader>s', group = 'Search' },
            { '<leader>sf', builtin.find_files, desc = 'Search files' },
            { '<leader>sg', builtin.live_grep, desc = 'Search live grep' },
            { '<leader>sw', builtin.grep_string, desc = 'Search current word' },
            { '<leader>sh', builtin.help_tags, desc = 'Search help' },

            -- The search here is driven by rg; add an .rgignore file to exclude things like vendored dependencies.
            { '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Search TODOs' },

            { '<leader>sT', builtin.builtin, desc = 'Search Telescope' },
            { '<leader>sd', builtin.diagnostics, desc = 'Search diagnostics' },
            { '<leader>s.', builtin.oldfiles, desc = 'Search Recent Files ("." for repeat},' },
        })
    end,
}
