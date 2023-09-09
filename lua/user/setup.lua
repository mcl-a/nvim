-- LUALINE
-- vim.g.ayuprefermirage = true
require('lualine').setup{
  options = {
    -- icons_enabled = false,
    -- theme = 'onedark',
    theme = 'OceanicNext',
    -- theme = 'ayu',
    component_separators = '|',
    section_separators = '',
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- LSP
-- enable the following language servers
local servers = {
  clangd = {},
  gopls = {},
  rust_analyzer = {},
  --pyright = {},
  pylsp = {},
  hls = {},
  -- tsserver = {},
  -- eslint = {},
  lua_ls = {
    Lua = {
      format = { enable = false, },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
      telemetry = { enable = false },
    },
  },
}

-- This fn gets run when an LSP server connects to a buffer
local on_attach = function(_, bufnr)
  for _, mapping in ipairs(require('user.keymaps').lsp_keymaps) do
    local key = mapping[1]
    local map = mapping[2]
    local desc = mapping[3]
    vim.keymap.set('n', key, map,
      { buffer = bufnr, noremap = true, silent = true, desc = desc })
  end
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

-- disable in buffer lsp diagnostic messages
vim.diagnostic.config({
  -- signs = false,
  underline = false,
  virtual_text = false,
  -- virtual_text = {spacing = 4},
})

-- CMP
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- TELESCOPE
require('telescope').setup {           -- defaults
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },

  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = 'smart_case',        -- or 'ignore_case' or 'respect_case'
                                       -- the default case_mode is 'smart_case'
    }
  }
}

-- Enable telescope fzf native
pcall(require('telescope').load_extension('fzf'))

-- WHICH-KEY
require('which-key').setup{
  window = {
    border = 'rounded',       -- none, single, double, shadow
    position = 'bottom',      -- bottom, top
    winblend = 0,
  }
}

-- TREE-SITTER
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'lua', 'python', 'vim', 'vimdoc', 'go', 'rust', 'haskell',
                       'javascript', 'typescript', 'fennel', 'scheme', 'bash' },
  -- auto_install = false,
  highlight = { enable = true },
  indent = { enable = true },
  sync_install = false,
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- TERMINAL
require('toggleterm').setup{
  size = 20,
  open_mapping = [[<c-\>]],
  close_on_exit = true,
  direction = 'float',
  float_opts = {
    border = 'curved',
  },
  shade_terminals = true
}

-- Python REPL
--[[
local Terminal = require('toggleterm.terminal').Terminal
local python = Terminal:new({ cmd = 'python3', hidden = true })
function _python_toggle()
  python:toggle()
end
keymap('n', '<leader>p', '<cmd>lua _python_toggle()<CR>', kopts)
]]
