# About

My custom emacs theme ported over to Neovim. All the code for this port is based on gruvbox.nvim by ellisonleao: https://github.com/ellisonleao/gruvbox.nvim

# Prerequisites

Neovim 0.8.0+

# Installing

## Using `packer`

```lua
use { "indy/athens.nvim" }
```

## Using `lazy.nvim`

```lua
{ "indy/athens.nvim", priority = 1000 , config = true, opts = ...}
```

## Using `vim-plug`

```vim
Plug 'indy/athens.nvim'
```

# Basic Usage

Inside `init.vim`

```vim
set background=dark " or light if you want light mode
colorscheme athens
```

Inside `init.lua`

```lua
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme athens]])
```

# Configuration

Additional settings for athens are:

```lua
-- Default options:
require("athens").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd("colorscheme athens")
```

**VERY IMPORTANT**: Make sure to call setup() **BEFORE** calling the colorscheme command, to use your custom configs

## Overriding

### Palette

You can specify your own palette colors. For example:

```lua
require("athens").setup({
    palette_overrides = {
        bright_green = "#990000",
    }
})
vim.cmd("colorscheme athens")
```

### Highlight groups

If you don't enjoy the current color for a specific highlight group, now you can just override it in the setup. For
example:

```lua
require("athens").setup({
    overrides = {
        SignColumn = {bg = "#ff9900"}
    }
})
vim.cmd("colorscheme athens")
```

It also works with treesitter groups and lsp semantic highlight tokens

```lua
require("athens").setup({
    overrides = {
        ["@lsp.type.method"] = { bg = "#ff9900" },
        ["@comment.lua"] = { bg = "#000000" },
    }
})
vim.cmd("colorscheme athens")
```

Please note that the override values must follow the attributes from the highlight group map, such as:

- **fg** - foreground color
- **bg** - background color
- **bold** - true or false for bold font
- **italic** - true or false for italic font

Other values can be seen in [`synIDattr`](<https://neovim.io/doc/user/builtin.html#synIDattr()>)
