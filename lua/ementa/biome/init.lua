local M = {}

local command = require('ementa.biome.command')

M.config = {
  -- Default path to use when no argument is provided
  default_path = nil,
  -- Custom command to run (e.g., {"pnpm", "exec", "biome", "lint"} or {"npm", "run", "lint"})
  command = nil,
}

function M.lint(path)
  -- Use provided path, or fall back to configured default path
  local target_path = path
  if (not target_path or target_path == "") and M.config.default_path then
    target_path = M.config.default_path
  end

  command.run_lint(target_path, M.config)
end

function M.setup(opts)
  opts = opts or {}
  M.config = vim.tbl_deep_extend("force", M.config, opts)
end

return M
