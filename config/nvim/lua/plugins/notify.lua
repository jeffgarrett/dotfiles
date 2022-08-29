local M = {}

function M.startup(use)
  use {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require "notify"
    end,
    requires = {
      "nvim-telescope/telescope.nvim",
    },
  }
end

return M
