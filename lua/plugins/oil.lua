return {
    'stevearc/oil.nvim',
    lazy = false,
    config = function()
        require('oil').setup({
            -- Only allow name editing.
            constrain_cursor = 'name',

            view_options = {
                -- Show hidden files.
                show_hidden = true,
            },
        })

        vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
    end,
}
