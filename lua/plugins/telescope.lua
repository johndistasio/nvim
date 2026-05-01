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
    end,
}
