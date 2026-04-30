-- https://djls.joshthomas.dev/en/latest/clients/neovim/#file-type-detection
-- Detect Django projects
local function is_django_project(path)
    local current = path
    while current ~= '/' do
        -- Check for manage.py
        if vim.fn.filereadable(current .. '/manage.py') == 1 then
            return true
        end

        -- Check for pyproject.toml with django dependency
        -- Note: This is a naive check that just searches for "django" in the file.
        -- A more robust approach would parse the TOML and check dependencies properly.
        local pyproject = current .. '/pyproject.toml'
        if vim.fn.filereadable(pyproject) == 1 then
            local content = vim.fn.readfile(pyproject)
            for _, line in ipairs(content) do
                if line:match('django') then
                    return true
                end
            end
        end

        current = vim.fn.fnamemodify(current, ':h')
    end
    return false
end

-- Auto-detect htmldjango filetype for Django projects
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.html',
    callback = function(args)
        local file_dir = vim.fn.fnamemodify(args.file, ':p:h')
        if is_django_project(file_dir) then
            vim.bo[args.buf].filetype = 'htmldjango'
        end
    end,
})
