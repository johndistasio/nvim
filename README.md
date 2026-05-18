# nvim

Neovim configuration based on kickstart.nvim.

# LSP Setup

LSP setup is done manually with [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) in `plugins/lspconfig.lua`.

The LSP must be installed separtely from Neovim and reachable at the path expected by (or configured via) that plugin.

## Key Bindings to Remember

### Code Editing

- `space-f`: format the current buffer
- `cl`: delete next character and enter insert mode
- `cc`: delete contents of line and enter insert mode
- `gcc`: toggle comments on line(s)

### LSP

- `grn`: rename the symbol under the cursor
- `gra`: run the Code Action available at that line, or open a menu to select if multiple
- `grr`: find references for the symbol under the cursor
- `gri`: go to the implemention of the symbol under the cursor
- `grd`: go to the definition of the symbol under the cursor
- `grD`: go to the declaration of the symbol under the cursor
- `grt`: go to the definition of the type of the symbol under the cursor
- `grx`: run the Codelens available at that line, or open a menu to select if multiple

### Navigation

- `space-sf`: search for files by name with a fuzzy finder
- `space-sg`: search file contents with a fuzzy finder
- `space-sw`: search for occurances of the word under the cursor
- `space-sh`: search Neovim help
- `space-st`: search for TODO comments
- `space-sd`: search for LSP diagnostics
- `space-s.`: search recently opened files



