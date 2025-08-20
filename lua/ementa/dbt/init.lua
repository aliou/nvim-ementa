local M = {}

---@class ementa.dbt.Config
---@field readonly_compiled_files boolean

---@type ementa.dbt.Config
local default_config = {
  readonly_compiled_files = true
}

---@param config ementa.dbt.Config | nil
M.setup = function(config)
  config = config and vim.tbl_deep_extend('force', default_config, config) or default_config

  -- TODO: Find `dbt-project.yml` file.

  if config.readonly_compiled_files then
    vim.filetype.add({
      pattern = {
        [".*/target/compiled/.*%.sql"] = 'dbt-compiled.sql',
        [".*/target/run/.*%.sql"] = 'dbt-compiled.sql',

        [".*/models/.*%.sql"] = 'dbt-model.sql',

        [".*/macros/.*%.sql"] = 'dbt-macro.sql',
      }
    })
  end
end

return M