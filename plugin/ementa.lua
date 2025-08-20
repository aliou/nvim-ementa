if vim.fn.has('nvim-0.11.0') == 0 then
  vim.notify('nvim-ementa requires at least nvim-0.11.0', vim.log.levels.ERROR)
  return
end

if vim.g.loaded_nvim_ementa == 1 then
  return
end
vim.g.loaded_nvim_ementa = 1

local biome = require('ementa.biome')

vim.api.nvim_create_user_command('BiomeLint', function(opts)
  biome.lint(opts.args)
end, {
  nargs = '?',
  complete = 'file',
  desc = 'Run Biome linter and populate quickfix list'
})

