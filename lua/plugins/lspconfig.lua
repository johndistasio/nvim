vim.opt.completeopt = { 'menuone', 'noselect', 'popup', 'preview', 'fuzzy' }

local lsp_attach_group = vim.api.nvim_create_augroup('lsp-attach', { clear = true })

local function setup_completion_on_attach(client, bufnr)
    -- Source: https://neovim.io/doc/user/lsp/#lsp-attach
    -- Optional: trigger autocompletion on EVERY keypress. May be slow!
    local chars = {}
    for i = 32, 126 do
        table.insert(chars, string.char(i))
    end
    client.server_capabilities.completionProvider.triggerCharacters = chars

    -- Enable built-in completion.
    -- https://neovim.io/doc/user/lsp/#lsp-completion
    vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        convert = function(item)
            return { abbr = item.label:gsub('%b()', '') }
        end,
    })
end

return {
    'neovim/nvim-lspconfig',
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = lsp_attach_group,

            -- The event parameter is an "event-data" table: https://neovim.io/doc/user/api/#event-data
            -- For this event, the LSP client ID is included as client_id.
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)

                if client:supports_method('textDocument/completion') then
                    setup_completion_on_attach(client, event.buf)
                end
            end,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),

            callback = function(_)
                vim.api.nvim_clear_autocmds({ group = lsp_attach_group })
            end,
        })

        local servers = {
            clangd = {},
            lua_ls = {},
            rust_analyzer = {},
            stylua = {},
            ts_ls = {},
        }

        for server, config in pairs(servers) do
            vim.lsp.config(server, config)
            vim.lsp.enable(server)
        end
    end,
}
