local M = {}

function M.startup(use)
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      -- local defaults = require("project_nvim.config").defaults.patterns
      -- table.insert(patterns, "WORKSPACE")
      require("project_nvim").setup {
        -- ignore_lsp = { "efm" },
        -- patterns = patterns,
        silent_chdir = false,
      }
      require("telescope").load_extension "projects"
    end,
    requires = {
      "nvim-telescope/telescope.nvim",
    },
  }
end

return M
