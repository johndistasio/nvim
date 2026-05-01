-- Set <space> as the global leader key.
vim.g.mapleader = ' '

-- Set <space> as the buffer-local leader key.
-- This could be set to something different to have different leader key shortcuts for filetype plugins.
vim.g.maplocalleader = ' '

-- Enable editorconfig support.
-- Neovim will find and parse .editorconfg files after running ftplugins and FileType autocommands.
vim.g.editorconfig = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

-- Show line numbers by default.
vim.o.number = true

-- Don't show the mode (we expect a statusbar plugin to do this).
vim.o.showmode = false

-- Enable mouse mode for resizing splits and selecting buffers with the mouse.
-- 'a' means all modes here.
vim.o.mouse = 'a'

-- From :help breakindent:
-- Every wrapped line will continue visually indented (same amount of
-- space as the beginning of that line), thus preserving horizontal blocks of text.
vim.o.breakindent = true

-- Save undo history.
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default.
vim.o.signcolumn = 'yes'

-- Write swap file to disk this many milliseconds after last input.
vim.o.updatetime = 250

-- Time in milliseconds to wait for a mapped sequence to complete.
vim.o.timeoutlen = 300

-- Open vertical splits to the right of the current window.
vim.o.splitright = true

-- Open horizontal splits below the current window.
vim.o.splitbelow = true

-- Show which line the cursor is on.
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s).
-- See `:help 'confirm'`
vim.o.confirm = true

-- Set the number of spaces that <Tab> inserts.
vim.o.tabstop = 4

-- Number of spaces to use for each indent; when 0, the value of tabstop will be used.
vim.o.shiftwidth = 0

-- Insert spaces instead of tabs.
vim.o.expandtab = true

-- Set rounded borders on popup windows so they're easier to read.
vim.o.winborder = 'rounded'

-- Disable providers for plugins in other languages.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Use treesitter parsing to determine fold locations.
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Set indentation level to close folds by default.
vim.opt.foldlevel = 10

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Configure diagnostics.
-- https://neovim.io/doc/user/diagnostic/#vim.diagnostic.Opts
vim.diagnostic.config({

    -- TODO
    update_in_insert = false,

    -- Sort diagnostics by severity. Higher severities are displayed first.
    severity_sort = true,

    -- Floating window options.
    -- https://neovim.io/doc/user/diagnostic/#vim.diagnostic.Opts.Float
    float = {
        -- TODO
        border = 'rounded',
        -- TODO
        source = 'if_many',
    },

    -- TODO
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- TODO
    virtual_lines = true,

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = { float = true },
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup({
    spec = {
        -- import your plugins
        { import = 'plugins' },
    },
    -- Don't automatically check for plugin updates.
    checker = { enabled = false },
})

vim.cmd.colorscheme('boo-berry')

--
-- keymaps
--

local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { desc = desc })
end

local wk = require('which-key')
local builtin = require('telescope.builtin')

map('<leader><leader>', builtin.buffers, 'Find buffers')

wk.add({ '<leader>s', group = 'Search' })
map('<leader>sf', builtin.find_files, 'Search files')
map('<leader>sg', builtin.live_grep, 'Search live grep')
map('<leader>sw', builtin.grep_string, 'Search current word')
map('<leader>sh', builtin.help_tags, 'Search help')
map('<leader>st', '<cmd>TodoTelescope<cr>', 'Search TODOs')
map('<leader>sT', builtin.builtin, 'Search Telescope')
map('<leader>sd', builtin.diagnostics, 'Search diagnostics')
map('<leader>s.', builtin.oldfiles, 'Search Recent Files ("." for repeat)')

-- Override some default keymaps with Telescope versions.
wk.add({ 'gr', group = 'LSP' })
map('grn', vim.lsp.buf.rename, 'Rename')
map('gra', vim.lsp.buf.code_action, 'Goto Code Action', { 'n', 'x' })
map('grr', builtin.lsp_references, 'Goto References')
map('gri', builtin.lsp_implementations, 'Goto Implementation')
map('grd', builtin.lsp_definitions, 'Goto Definition')
map('grD', vim.lsp.buf.declaration, 'Goto Declaration')
map('grt', builtin.lsp_type_definitions, 'Goto Type Definition')
map('grx', vim.lsp.codelens.run, 'Run Codelens at Line')
map('gro', builtin.lsp_document_symbols, 'Open Document Symbols')
map('grw', builtin.lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

--
-- other configuration
--

require('config.django')
