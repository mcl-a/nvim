local keymap = vim.keymap.set

local nmap = function(keys, func)
  vim.keymap.set('n', keys, func, { silent = true, noremap = true })
end

-- ensure space is unmapped
keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- alternative to esc
keymap('i', 'jk', '<Esc>')
keymap('i', 'kj', '<Esc>')

-- close buffers
nmap('<C-q>', '<cmd>bdelete!<CR>')

-- source the current buffer
nmap('<leader>s', ':source<CR>')

-- Lazy UI
nmap('<leader>P', ':Lazy<CR>')

-- Mason UI
nmap('<leader>M', '<cmd>Mason<CR>')

-- LSP Info
nmap('<leader>L', '<cmd>LspInfo<CR>')

-- netrw
nmap('<leader>t', ':Lexplore<CR>')

-- zenmode
nmap('<leader>z', '<cmd>ZenMode<CR>')

-- split screen and buffer navigation
nmap('<leader>v', ':vsplit<CR><C-w>l')
nmap('<c-space>', '<C-w>w')
nmap('<c-a-space>', ':bprevious<CR>')

-- Window navigation
nmap('<leader><left>', '<C-w>h')
nmap('<leader><right>', '<C-w>l')
nmap('<leader><up>', '<C-w>k')
nmap('<leader><down>', '<C-w>j')

-- Window resize with arrows
nmap('<C-Up>', ':resize -2<CR>')
nmap('<C-Down>', ':resize +2<CR>')
nmap('<C-Right>', ':vertical resize -2<CR>')
nmap('<C-Left>', ':vertical resize +2<CR>')

-- visual - stay in indent mode
nmap('<', '<gv')
nmap('>', '>gv')

-- Clear highlights
nmap('<leader>h', '<cmd>nohlsearch<CR>')

-- Toggle word highlight .. clear all highlights
nmap('<leader>Ht', '<cmd>lua require"mywords".hl_toggle()<cr>')
nmap('<leader>Hc', '<cmd>lua require"mywords".uhl_all()<cr>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
  { silent = true, noremap = true, desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next,
  { silent = true, noremap = true, desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,
  { silent = true, noremap = true, desc = 'Open diagnostic messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
  { silent = true, noremap = true, desc = 'Open diagnostics list' })

-- See `:help telescope.builtin`
nmap('<leader>ff', ':Telescope find_files<CR>')
nmap('<leader>fg', ':Telescope live_grep<CR>')
nmap('<leader>fw', ':Telescope grep_string<CR>')
nmap('<leader>fG', ':Telescope git_files<CR>')
nmap('<leader><space>', ':Telescope buffers<CR>')
nmap('<leader>fc', ':Telescope commands<CR>')
nmap('<leader>fm', ':Telescope man_pages sections=1,2,3,4,5,6,7,8<CR>')
nmap('<leader>fM', ':Telescope marks<CR>')
nmap('<leader>fq', ':Telescope quickfix<CR>')
nmap('<leader>fj', ':Telescope jumplist<CR>')
nmap('<leader>?', ':Telescope oldfiles<CR>')
nmap('<leader>fd', ':Telescope lsp_definitions<CR>')
nmap('<leader>fr', ':Telescope lsp_references<CR>')
nmap('<leader>fi', ':Telescope lsp_implementations<CR>')
nmap('<leader>fT', ':Telescope lsp_type_definitions<CR>')
nmap('<leader>fR', ':Telescope registers<CR>')
nmap('<leader>fk', ':Telescope keymaps<CR>')
nmap('<leader>fsd', ':Telescope lsp_document_symbols<CR>')
nmap('<leader>fsw', ':Telescope lsp_workspace_symbols<CR>')
nmap('<leader>ft', ':Telescope treesitter<CR>')
nmap('<leader>fD', ':Telescope diagnostics<CR>')
nmap('<leader>fh', ':Telescope help_tags<CR>')
nmap('<leader>fp', ':Telescope projects<CR>')
nmap('<leader>fP', ':Telescope planets<CR>')
-- telescope notify history
nmap('<leader>fn',
  [[<Cmd>lua require('telescope').extensions.notify.notify({results_title='Notification History', prompt_title='Search Messages'})<CR>]])
-- fuzzy search in current buffer
vim.keymap.set('n', '<leader>/',
  function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end,
  { silent = true, noremap = true, desc = '[/] Fuzzily search in current buffer' })

-- DAP
-- nmap('<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<cr>')
-- nmap('<leader>dc', '<cmd>lua require"dap".continue()<cr>')
-- nmap('<leader>di', '<cmd>lua require"dap".step_into()<cr>')
-- nmap('<leader>do', '<cmd>lua require"dap".step_over()<cr>')
-- nmap('<leader>dO', '<cmd>lua require"dap".step_out()<cr>')
-- nmap('<leader>dr', '<cmd>lua require"dap".repl.toggle()<cr>')
-- nmap('<leader>dl', '<cmd>lua require"dap".run_last()<cr>')
-- nmap('<leader>du', '<cmd>lua require"dapui".toggle()<cr>')
-- nmap('<leader>dt', '<cmd>lua require"dap".terminate()<cr>')

-- Maps below are exported for plugin setup fns to consume
local M = {}

-- LSP
M.lsp_keymaps = {
  -- keys         mapping            doc
  -- See `:help K` for why this keymap
  { '<leader>K',  vim.lsp.buf.hover, 'Hover' },
  { '<C-k>', vim.lsp.buf.signature_help, 'Signature help' },
  { '<leader>ls', vim.lsp.buf.signature_help, 'Signature help' },
  { '<leader>ld', vim.lsp.buf.definition, 'Goto definition' },
  { '<leader>lr', vim.lsp.buf.references, 'Goto references' },
  { '<leader>lD', vim.lsp.buf.declaration, 'Goto declaration' },
  { '<leader>lI', vim.lsp.buf.implementation, 'Goto implementation' },
  { '<leader>lT', vim.lsp.buf.type_definition, 'Goto type definition' },
  { '<leader>lR', vim.lsp.buf.rename, 'Rename symbol' },
  { '<leader>lF', vim.lsp.buf.format, 'Format buffer' },
  { '<leader>la', vim.lsp.buf.code_action, 'Apply code action' },
  { '<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add workspace folder' },
  { '<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder' },
  { '<leader>wl',
    function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    'List workspace folders' },
}

return M
