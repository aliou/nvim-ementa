-- Unified Amp plugin for permissions and message files
-- Maintainer: Aliou Diallo

vim.filetype.add({
  filename = {
    ["permissions.txt"] = "amp-permissions",
    ["message.amp.md"] = "markdown.amp",
  },
})
