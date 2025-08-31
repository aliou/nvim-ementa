-- Unified Amp plugin for permissions and message files
-- Maintainer: Aliou Diallo

-- TODO: Move this under a ementa dir? 

vim.filetype.add({
  filename = {
    ["permissions.txt"] = "amp-permissions",
    ["message.amp.md"] = "markdown.amp",
  },
})
