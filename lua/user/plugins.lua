return {
  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- Note: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      'folke/neodev.nvim',
    },
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Show pending keybinds
  { 'folke/which-key.nvim', opts = {} },

  -- Use lualine as statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      {
        'ahmedkhalf/project.nvim',
        config = function()
          require('project_nvim').setup({
            -- Note: lsp doesn't work as well with multiple langs in a project
            -- detection methods = {'lsp', 'pattern'},
            detection_methods = {'pattern'},

            -- patterns used to detect the root dir
            patterns = {'.git', 'Makefile', 'package.json'},
          })

          require('telescope').load_extension('projects')
        end
      },
    },
    opts = {
      defaults = {
        --prompt_prefix = ' ',
        --selection_caret = ' ',
        --path_display = { 'smart' },
        file_ignore_patterns = { '.git/', 'node_modules' },
      },
    },
  },

  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- leap around the buffer(s)
  { 'ggandor/leap.nvim', opts = {} },

  { 'akinsho/toggleterm.nvim', version = '*', config = true },

  { 'rcarriga/nvim-notify', opts = {} },

  -- manage marks
  { 'chentoast/marks.nvim', opts = {} },

  -- toggle highlight of words
  { 'dwrdx/mywords.nvim' },

  {
    'folke/zen-mode.nvim',
    opts = {
      window = {
        -- backdrop = 0.95,           -- shade the backdrop of the zen window
        -- width = 120,               -- width of the zen window
        -- height = 1,                -- height of the zen window
        options = {
          signcolumn = 'no',       -- disable sign column
          number = false,          -- disable number column
          relativenumber = false,  -- disable relative numbers
          -- cursorline = false,      -- disable cursorline
          foldcolumn = '0',        -- disable fold column
          list = false,            -- disable whitespace characters
        },
      },
    },
  },

  -- startup screen
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      require('alpha').setup(require('alpha.themes.startify').config)
    end
  },

  {
    'andreypopp/vim-colors-plain',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme plain]])
    end,
  },
}
