-- TODO: Boostrap should be in a separate script along with language install tools
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Collection of configurations for the built-in LSP client
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("lsp").setup(require "lspconfig")
    end,
  }

  -- LSP extensions
  use "nvim-lua/lsp_extensions.nvim"

  -- Solarized color scheme
  use "overcache/NeoSolarized"

  --   -- Simple plugins can be specified as strings
  --   use '9mm/vim-closer'
  --
  --   -- Lazy loading:
  --   -- Load on specific commands
  --   use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
  --
  --   -- Load on an autocommand event
  --   use {'andymass/vim-matchup', event = 'VimEnter'}
  --
  --   -- Load on a combination of conditions: specific filetypes or commands
  --   -- Also run code after load (see the "config" key)
  --   use {
  --     'w0rp/ale',
  --     ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
  --     cmd = 'ALEEnable',
  --     config = 'vim.cmd[[ALEEnable]]'
  --   }
  --
  --   -- Plugins can also depend on rocks from luarocks.org:
  --   use {
  --     'my/supercoolplugin',
  --     rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
  --   }
  --
  --   -- You can specify rocks in isolation
  --   use_rocks 'penlight'
  --   use_rocks {'lua-resty-http', 'lpeg'}
  --
  --   -- Local plugins can be included
  --   use '~/projects/personal/hover.nvim'
  --
  --   -- Plugins can have post-install/update hooks
  --   use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
  --
  --   -- Post-install/update hook with neovim command
  --   use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  --
  --   -- Post-install/update hook with call of vimscript function with argument
  --   use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
  --
  --   -- Use specific branch, dependency and run lua file after load
  --   use {
  --     'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
  --     requires = {'kyazdani42/nvim-web-devicons'}
  --   }
  --
  --   -- Use dependency and run lua function after load
  --   use {
  --     'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
  --     config = function() require('gitsigns').setup() end
  --   }
  --
  --   -- You can specify multiple plugins in a single call
  --   use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}
  --
  --   -- You can alias plugin names
  --   use {'dracula/vim', as = 'dracula'}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end

  -- TODO: Why does this need sync instead of compile?
  vim.api.nvim_create_autocmd("BufWritePost", { callback = require("packer").sync, pattern = "plugins.lua" })
end)

-- " Find files using Telescope command-line sugar.
-- nnoremap <leader>ff <cmd>Telescope find_files<cr>
-- nnoremap <leader>fg <cmd>Telescope live_grep<cr>
-- nnoremap <leader>fb <cmd>Telescope buffers<cr>
-- nnoremap <leader>fh <cmd>Telescope help_tags<cr>
-- Plug 'nvim-lua/popup.nvim'
-- Plug 'nvim-lua/plenary.nvim'
-- Plug 'nvim-telescope/telescope.nvim'
-- Plug 'mfussenegger/nvim-dap'
--
-- Plug 'simrat39/rust-tools.nvim'
--
-- " Completion framework
-- Plug 'hrsh7th/nvim-cmp'
--
-- " LSP completion source for nvim-cmp
-- Plug 'hrsh7th/cmp-nvim-lsp'
--
-- " Snippet completion source for nvim-cmp
-- Plug 'hrsh7th/cmp-vsnip'
--
-- " Other usefull completion sources
-- Plug 'hrsh7th/cmp-path'
-- Plug 'hrsh7th/cmp-buffer'
--
-- " Snippet engine
-- Plug 'hrsh7th/vim-vsnip'
--
-- " Fuzzy finder
-- " Optional
-- Plug 'nvim-lua/popup.nvim'
-- Plug 'nvim-lua/plenary.nvim'
-- Plug 'nvim-telescope/telescope.nvim'
