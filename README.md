# nvim-ementa

A collection of simple Neovim tools and snippets that could be part of a personal config but might be useful for others.

## Requirements

- Neovim >= 0.11.0

## Installation

### Using vim.pack (neovim 0.12+)

Neovim's built-in plugin manager `vim.pack` is currently under development. Once available:

```lua
vim.pack.add({ src = 'aliou/nvim-ementa' })
```

### Using mini.deps

```lua
local MiniDeps = require('mini.deps')
MiniDeps.add({
  source = 'aliou/nvim-ementa',
})
```

### Using lazy.nvim

```lua
{
  'aliou/nvim-ementa',
  config = function()
    -- Optional configuration
  end,
}
```

### Using Neovim's Native Package System

Clone the repository into your packpath:

```bash
# For automatic loading on startup
git clone https://github.com/aliou/nvim-ementa.git \
  ~/.local/share/nvim/site/pack/plugins/start/nvim-ementa

# Or for optional loading (use :packadd nvim-ementa to load)
git clone https://github.com/aliou/nvim-ementa.git \
  ~/.local/share/nvim/site/pack/plugins/opt/nvim-ementa
```

## Sub-plugins

### biome

Integrates the Biome linter into Neovim:
- Provides `:BiomeLint [path]` command to run Biome linting
- Populates the quickfix list with linting results
- Configurable default paths and custom commands

#### Configuration

```lua
require('ementa.biome').setup({
  -- Default path to lint when no argument provided
  default_path = nil,
  -- Custom command to run (e.g., {"pnpm", "exec", "biome", "lint"})
  command = nil,
})
```

#### Usage

```vim
:BiomeLint              " Lint current file or configured default
:BiomeLint src/         " Lint specific path
:BiomeLint %            " Lint current file explicitly
```

### dbt

Adds support for dbt (data build tool) SQL files:
- Automatically detects dbt compiled and model files
- Sets appropriate filetypes for files in dbt project structure:
  - `dbt-compiled.sql` for compiled/run files
  - `dbt-model.sql` for model files
  - `dbt-macro.sql` for macro files
- Optional readonly mode for compiled files

#### Configuration

```lua
require('ementa.dbt').setup({
  -- Make compiled files readonly by default
  readonly_compiled_files = true,
})
```

### vim-test tmux popup strategy

Runs tests in a tmux popup window (falls back to basic strategy when not in tmux).

#### Usage

```lua
-- Set tmux_popup as your test strategy
vim.g['test#strategy'] = 'tmux_popup'
```

## Commands

| Command | Description |
|---------|-------------|
| `:BiomeLint [path]` | Run Biome linter and populate quickfix list |
