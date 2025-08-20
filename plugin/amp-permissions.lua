-- Filetype detection for Amp permission files

vim.filetype.add({
  filename = {
    ["permissions.txt"] = "amp-permissions",
  },
})
