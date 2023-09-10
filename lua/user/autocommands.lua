-- Filetype configurations
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua,javascript,json,xml,yaml,toml,fennel,scheme,commonlisp,clojure',
  -- command = 'setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab'
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go,make',
  callback = function()
    vim.opt_local.expandtab = false
  end
})

-- Close info buffers with q
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'qf', 'help', 'man', 'lspinfo', 'spectre_panel' },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Add the same comment color in each theme
--    autocmd VimEnter * hi Comment guifg=#00c243
--    autocmd VimEnter * hi Comment guifg=#5fb950
--    autocmd VimEnter * hi Comment guifg=#2ea542
vim.cmd([[
  augroup CustomCommentColor
    autocmd!
    autocmd VimEnter * hi Comment guifg=#2ea542
  augroup END
]])

-- Toggle number and relativenumber based on the mode
vim.cmd([[
  augroup NumberToggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != 'i' | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]])
