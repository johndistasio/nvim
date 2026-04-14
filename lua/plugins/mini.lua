return {
    'nvim-mini/mini.statusline',

    -- Use 'main' version as recommended per the documentation.
    version = false,

    config = function()
        require('mini.statusline').setup({ use_icons = false })
    end,
}
