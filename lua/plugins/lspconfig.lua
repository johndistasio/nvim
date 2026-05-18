-- TODO: describe me
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

                if client and client:supports_method('textDocument/completion') then
                    setup_completion_on_attach(client, event.buf)
                end

                -- Enable inlay hints for available codelenses and references.
                vim.lsp.codelens.enable(true, { bufnr = event.buf })

                -- Override some default keymaps with Telescope versions.
                local wk = require('which-key')
                local builtin = require('telescope.builtin')

                wk.add({
                    { 'gr', group = 'LSP' },
                    { 'grn', vim.lsp.buf.rename, desc = 'Rename' },
                    { 'gra', vim.lsp.buf.code_action, desc = 'Goto Code Action', mode = { 'n', 'x' } },
                    { 'grr', builtin.lsp_references, desc = 'Goto References' },
                    { 'gri', builtin.lsp_implementations, desc = 'Goto Implementation' },
                    { 'grd', builtin.lsp_definitions, desc = 'Goto Definition' },
                    { 'grD', vim.lsp.buf.declaration, desc = 'Goto Declaration' },
                    { 'grt', builtin.lsp_type_definitions, desc = 'Goto Type Definition' },
                    { 'grx', vim.lsp.codelens.run, desc = 'Run Codelens at Line' },
                    { 'gro', builtin.lsp_document_symbols, desc = 'Open Document Symbols' },
                    { 'grw', builtin.lsp_dynamic_workspace_symbols, desc = 'Open Workspace Symbols' },
                })
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
            gopls = {},
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
