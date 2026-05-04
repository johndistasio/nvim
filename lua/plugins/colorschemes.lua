local function colorscheme(scheme, deps)
    deps = deps or {}
    return { scheme, lazy = false, priority = 1000, dependencies = deps }
end

return {
    colorscheme('booberrytheme/boo-berry.nvim'),
    colorscheme('johndistasio/sherbet.nvim'),
    colorscheme('sainnhe/everforest'),
    colorscheme('savq/melange-nvim'),
    colorscheme('Shatur/neovim-ayu'),
    {
        'e-ink-colorscheme/e-ink.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            -- Customizations must happen after the colorscheme is loaded.
            vim.api.nvim_create_autocmd('Colorscheme', {
                pattern = 'e-ink',
                callback = function()
                    require('e-ink').setup()
                    local hl = vim.api.nvim_set_hl
                    local everforest = require('e-ink.palette').everforest()

                    -- TODO: replace with customizations i want long term
                    hl(0, 'Comment', { fg = everforest.green })
                end,
            })
        end,
    },
}
