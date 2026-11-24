local function colorscheme(scheme, deps)
    deps = deps or {}
    return { scheme, lazy = false, priority = 1000, dependencies = deps }
end

return {
    colorscheme('Mofiqul/adwaita.nvim'),
    colorscheme('FrenzyExists/aquarium-vim'),
    colorscheme('ficcdaf/ashen.nvim'),
    colorscheme('booberrytheme/boo-berry.nvim'),
    colorscheme('zitrocode/carvion.nvim'),
    colorscheme('Aejkatappaja/cendre'),
    colorscheme('DeviusVim/deviuspro.nvim'),
    colorscheme('fdemb/dusk.nvim'),
    colorscheme('ember-theme/nvim'),
    colorscheme('sainnhe/everforest'),
    colorscheme('xiantang/darcula-dark.nvim'),
    colorscheme('savq/melange-nvim'),
    colorscheme('xero/miasma.nvim'),
    colorscheme('Shatur/neovim-ayu'),
    colorscheme('Yazeed1s/oh-lucy.nvim'),
    colorscheme('kvrohit/rasmus.nvim'),
    colorscheme('johndistasio/sherbet.nvim'),
    colorscheme('rezniqov/soviet.nvim'),
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
