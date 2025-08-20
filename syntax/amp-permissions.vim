" Vim syntax file
" Language: Amp Permission Rules
" Maintainer: Aliou Diallo
" Last Change: 2025 Aug 20
" Filenames: amp-permissions.txt

if exists('b:current_syntax')
  finish
endif

" Comments starting with #
syn match   ampPermissionsComment   "#.*$"

" Core actions
syn keyword ampPermissionsAction    allow reject ask delegate

" Action arguments (--context, --to, etc.)
syn match   ampPermissionsArgument  /\v--[A-Za-z0-9_-]+/

" Tool names (including glob patterns)
syn match   ampPermissionsTool      /\v[A-Za-z0-9_*?./-]+/

" Parameter matching arguments (--cmd, --path, etc.)
syn match   ampPermissionsParam     /\v--[A-Za-z0-9_-]+:/

" Quoted strings (single and double)
syn region  ampPermissionsString    start=+"+ skip=+\\.+ end=+"+   oneline
syn region  ampPermissionsString    start=+'+ skip=+\\.+ end=+'+   oneline

" Numbers
syn match   ampPermissionsNumber    /\v[-+]?\d+(\.\d+)?/

" Boolean and special values
syn keyword ampPermissionsBoolean   true false null

" Context values
syn keyword ampPermissionsContext   thread subagent

" Operators and special characters
syn match   ampPermissionsOperator  /[:=]/

" Default highlighting
hi def link ampPermissionsComment   Comment
hi def link ampPermissionsAction    Keyword
hi def link ampPermissionsArgument  Identifier
hi def link ampPermissionsTool      Function
hi def link ampPermissionsParam     Type
hi def link ampPermissionsString    String
hi def link ampPermissionsNumber    Number
hi def link ampPermissionsBoolean   Boolean
hi def link ampPermissionsContext   Constant
hi def link ampPermissionsOperator  Operator

let b:current_syntax = 'amp-permissions'
