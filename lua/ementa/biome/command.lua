local M = {}

local function parse_github_format(raw_line)
  local pattern = "^::(%w+)%s+title=([^,]+),file=([^,]+),line=(%d+),endLine=(%d+),col=(%d+),endColumn=(%d+)::(.+)$"
  local severity, title, file, line, endLine, col, endColumn, message = raw_line:match(pattern)

  if severity and file and line and col and message then
    return {
      filename = file,
      lnum = tonumber(line),
      end_lnum = tonumber(endLine),
      col = tonumber(col),
      end_col = tonumber(endColumn),
      text = string.format("[%s] %s", title, message),
      type = severity == "error" and "E" or "W"
    }
  end

  return nil
end

function M.run_lint(path, config)
  config = config or {}
  local cmd

  if config.command then
    -- Use custom command provided by user
    cmd = vim.deepcopy(config.command)

    -- Check if the command already contains --reporter=github
    local has_reporter = false
    for _, arg in ipairs(cmd) do
      if arg:match("%-%-reporter") then
        has_reporter = true
        break
      end
    end

    -- Add reporter if not already present
    if not has_reporter then
      table.insert(cmd, "--reporter=github")
    end
  else
    -- Default biome command
    cmd = { "biome", "lint", "--reporter=github" }
  end

  if path and path ~= "" then
    table.insert(cmd, path)
  end

  -- Notify that linting has started
  local target = path and path ~= "" and path or "current directory"
  vim.notify(string.format("Biome: Linting %s...", target), vim.log.levels.INFO)

  local output = {}
  local qf_items = {}

  local job_id = vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(output, line)
            local item = parse_github_format(line)
            if item then
              table.insert(qf_items, item)
            end
          end
        end
      end
    end,
    on_stderr = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(output, line)
            local item = parse_github_format(line)
            if item then
              table.insert(qf_items, item)
            end
          end
        end
      end
    end,
    on_exit = function(_, _)
      if #qf_items > 0 then
        vim.fn.setqflist({}, 'r', {
          title = 'Biome Lint',
          items = qf_items
        })

        local error_count = 0
        local warning_count = 0
        for _, item in ipairs(qf_items) do
          if item.type == "E" then
            error_count = error_count + 1
          else
            warning_count = warning_count + 1
          end
        end

        -- Only open quickfix if there are errors
        if error_count > 0 then
          vim.cmd('copen')
        else
          -- Close quickfix if no errors (only warnings)
          vim.cmd('cclose')
        end

        local msg = string.format("Biome: Linting complete - Found %d error(s) and %d warning(s)", error_count,
          warning_count)
        if error_count > 0 then
          vim.notify(msg, vim.log.levels.ERROR)
        elseif warning_count > 0 then
          vim.notify(msg, vim.log.levels.WARN)
        end
      else
        -- Close quickfix when no issues
        vim.cmd('cclose')
        vim.fn.setqflist({}, 'r', {
          title = 'Biome Lint',
          items = {}
        })
        vim.notify("Biome: Linting complete - No issues found", vim.log.levels.INFO)
      end
    end
  })

  if job_id == 0 then
    vim.notify("Failed to start biome command", vim.log.levels.ERROR)
  elseif job_id == -1 then
    vim.notify("Biome command not found. Please ensure biome is installed and in your PATH", vim.log.levels.ERROR)
  end
end

return M

