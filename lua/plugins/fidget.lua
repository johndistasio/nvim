return {
    'j-hui/fidget.nvim',
    event = 'VimEnter',
    opts = {
        notification = {
            -- Override vim.notify() with fidget.notify()
            override_vim_notify = true,
        },
    },
}
