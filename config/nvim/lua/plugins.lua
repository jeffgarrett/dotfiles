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

  -- Autocompletion plugin
  use {
    "hrsh7th/nvim-cmp",
    config = function()
      -- luasnip setup
      local luasnip = require "luasnip"

      -- nvim-cmp setup
      local cmp = require "cmp"
      cmp.setup {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
      }
    end,
  }
  use "hrsh7th/cmp-nvim-lsp" -- LSP source for nvim-cmp
  use "saadparwaiz1/cmp_luasnip" -- Snippets source for nvim-cmp
  -- Snippets plugin
  use "L3MON4D3/LuaSnip"

  use "tpope/vim-fugitive" -- Git commands in nvim
  use "tpope/vim-rhubarb" -- Fugitive-companion to interact with github
  -- use "ludovicchabant/vim-gutentags" -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
      }
      --Add leader shortcuts
      vim.api.nvim_set_keymap(
        "n",
        "<leader><space>",
        [[<cmd>lua require('telescope.builtin').buffers()<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>sf",
        [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>sb",
        [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>sh",
        [[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>st",
        [[<cmd>lua require('telescope.builtin').tags()<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>sd",
        [[<cmd>lua require('telescope.builtin').grep_string()<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>sp",
        [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>so",
        [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>?",
        [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]],
        { noremap = true, silent = true }
      )
    end,
    requires = { "nvim-lua/plenary.nvim" },
  }
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    config = function()
      require("telescope").load_extension "fzf"
    end,
    requires = { "nvim-telescope/telescope.nvim" },
    run = "make",
  }

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
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
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
    "lewis6991/spellsitter.nvim",
    config = function()
      require("spellsitter").setup()
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

  -- Dim outside active context
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {}
      vim.api.nvim_create_autocmd("BufEnter", { callback = require("twilight").enable })
    end,
  }

  -- Add git related info in the signs columns and popups
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      }
    end,
    requires = { "nvim-lua/plenary.nvim" },
  }

  -- Add indentation guides even on blank lines
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      --Map blankline
      require("indent_blankline").setup {
        -- char = "┊",
        -- filetype_exclude = { "help", "packer" },
        -- buftype_exclude = { "terminal", "nofile" },
        -- show_trailing_blankline_indent = false,
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
      }
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
