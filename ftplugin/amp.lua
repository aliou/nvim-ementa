-- Amp Message Markdown filetype plugin
-- Maintainer: Aliou Diallo

-- Set up syntax highlighting for @paths
vim.cmd('runtime! syntax/markdown.vim')
vim.b.current_syntax = nil

-- Define highlight group
vim.api.nvim_set_hl(0, 'ampMsgPath', { link = 'Identifier', default = true })

-- Match @paths using vim.fn.matchadd for proper containedin behavior
vim.fn.matchadd('ampMsgPath', '@\\S\\+')

vim.b.current_syntax = 'amp.markdown'
