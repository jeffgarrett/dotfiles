local M = {}

function M.startup(use)
  use {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup {
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      }
    end,
    requires = { "kyazdani42/nvim-web-devicons" },
    tag = "nightly",
  }
end

return M
