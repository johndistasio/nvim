return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local ts = require('nvim-treesitter')

        ts.setup({
            install_dir = vim.fn.stdpath('data') .. '/site',
        })

        ts.install({
            'bash',
            'c',
            'cpp',
            'css',
            'diff',
            'dockerfile',
            'go',
            'gomod',
            'hcl',
            'html',
            'htmldjango',
            'java',
            'javascript',
            'json',
            'lua',
            'markdown',
            'markdown_inline',
            'python',
            'rust',
            'sql',
            'terraform',
            'toml',
            'tsx',
            'typescript',
            'yaml',
        })

        -- Enable tree-sitter highlighting for any buffer with an installed parser.
        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
            end,
        })
    end,
}
