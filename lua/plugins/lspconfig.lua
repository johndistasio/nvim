return {
    'neovim/nvim-lspconfig',
    config = function()
        local servers = {
            clangd = {},
            ts_ls = {},
            stylua = {},
        }

        for server, config in pairs(servers) do
            vim.lsp.config(server, config)
            vim.lsp.enable(server)
        end
    end,
}
