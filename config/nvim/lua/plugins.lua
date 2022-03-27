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
  -- use "nvim-lua/lsp_extensions.nvim"

  --   -- Post-install/update hook with neovim command
  use {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup {
        -- One of "all", "maintained" (parsers with maintainers), or a list of languages
        ensure_installed = "maintained",
        highlight = {
          enable = true, -- false will disable the whole extension
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        indent = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      }
    end,
    run = ":TSUpdate",
  }

  -- Additional textobjects for treesitter
  use "nvim-treesitter/nvim-treesitter-textobjects"

  -- Easily comment and uncomment with "gc"
  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  }

  use {
    "romgrk/nvim-treesitter-context",
    requires = "nvim-treesitter/nvim-treesitter",
  }

  -- Solarized color scheme
  use {
    "ishan9299/nvim-solarized-lua",
    config = function()
      vim.cmd "colorscheme solarized"
    end,
  }

  -- Status line and tab line
  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup {
        options = {
          theme = "solarized",
        },
        sections = {
          lualine_c = {
            { require("nvim-treesitter").statusline },
          },
        },
        tabline = {
          lualine_a = { "buffers" },
        },
      }
    end,
    requires = { "kyazdani42/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end

  -- TODO: Why does this need sync instead of compile?
  vim.api.nvim_create_autocmd("BufWritePost", { callback = require("packer").sync, pattern = "plugins.lua" })
end)
