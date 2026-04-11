--s Set <space> as the global leader key.
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
vim.o.number =  true

-- Don't show the mode (we expect a statusbar plugin to do this).
vim.o.showmode = false

-- Enable mouse mode for resizing splits and selecting buffers with the mouse.
-- 'a' means all modes here.
vim.o.mouse = 'a'

-- From :help breakindent:
-- Every wrapped line will continue visually indented (same amount of
-- space as the beginning of that line), thus preserving horizontal blocks
-- of text.
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

-- Show which line your cursor is on.
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

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Don't automatically check for plugin updates.
    checker = { enabled = false },
})

vim.cmd.colorscheme 'ayu-mirage'

require("config.django")

