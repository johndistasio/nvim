local function colorscheme(scheme, deps)
    deps = deps or {}
    return { scheme, lazy = false, priority = 1000, dependencies = deps }
end

return {
    colorscheme('booberrytheme/boo-berry.nvim'),
    colorscheme('e-ink-colorscheme/e-ink.nvim'),
    colorscheme('NTBBloodbath/doom-one.nvim'),
    colorscheme('olivercederborg/poimandres.nvim'),
    colorscheme('savq/melange-nvim'),
    colorscheme('Shatur/neovim-ayu'),
    colorscheme('xiantang/darcula-dark.nvim'),
}
