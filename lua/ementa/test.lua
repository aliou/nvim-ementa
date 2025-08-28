local M = {}

-- Simple tmux popup strategy for vim-test
function M.tmux_popup_strategy(cmd)
  -- Check if we're in tmux
  if not vim.env.TMUX or vim.env.TMUX == "" then
    -- Fall back to basic strategy
    vim.fn["test#strategy#basic"](cmd)
    return
  end

  -- Get the project root
  local project_root
  local test_root = vim.g["test#project_root"]

  if test_root then
    if type(test_root) == "function" then
      project_root = test_root()
    else
      project_root = test_root
    end
  else
    project_root = vim.fn.getcwd()
  end

  -- Build command to run with PATH
  local full_cmd = string.format(
    "PATH=%s $SHELL -lc %s",
    vim.fn.shellescape(vim.env.PATH or ""),
    vim.fn.shellescape(cmd)
  )

  -- Run in tmux popup with hardcoded settings
  local tmux_cmd = {
    "tmux",
    "display-popup",
    "-d", project_root, -- Set working directory
    "-T", string.format("vim-test: %s", cmd), -- Set title
    "-w", "80%",
    "-h", "80%",
    "-b", "rounded",
    "-EE", -- Auto-close on successful exit.
    full_cmd
  }

  -- Execute the command
  vim.fn.system(tmux_cmd)

  -- Redraw the screen
  vim.cmd.redraw()
end

return M
