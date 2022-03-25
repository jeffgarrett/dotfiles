local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }

  -- TODO
  -- require'completion'.on_attach(client)

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "g,", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    vim.api.nvim_create_autocmd("BufWritePre", { buffer = bufnr, callback = vim.lsp.buf.formatting_sync })
  end
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, "v", "g,", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end
end

vim.fn.sign_define("DiagnosticSignError", { text = "🔴", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "🟠", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInformation", { text = "🔵", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "🟢", texthl = "DiagnosticSignHint" })

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- TODO: pyright
-- TODO: rust_analyzer

return {
  filetypes = {
    "bzl",
    "lua",
    "c",
    "cpp",
    "objc",
    "objcpp",
  },
  setup = function(lsp)
    lsp.clangd.setup {
      on_attach = on_attach,
    }
    lsp.efm.setup {
      init_options = { documentFormatting = true },
      filetypes = { "bzl", "lua" },
      on_attach = on_attach,
      settings = {
        rootMarkers = { ".git/" },
        languages = {
          bzl = {
            {
              lintCommand = "bazel run --ui_event_filters=-info,-stdout,-stderr --noshow_progress @com_github_bazelbuild_buildtools//buildifier:buildifier -- -lint=warn -mode=check -warnings=-function-docstring-args,-module-docstring,-function-docstring -path ${INPUT}",
              lintIgnoreExitCode = true,
              lintStdin = true,
              formatCommand = "bazel run --ui_event_filters=-info,-stdout,-stderr --noshow_progress @com_github_bazelbuild_buildtools//buildifier:buildifier -- -mode=fix -path ${INPUT}",
              formatStdin = true,
            },
          },
          lua = {
            { formatCommand = "stylua --search-parent-directories -", formatStdin = true },
          },
        },
      },
    }
    lsp.sumneko_lua.setup {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Setup your lua path
            path = runtime_path,
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }
  end,
}

-- " nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
-- "nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
-- "nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
--
-- -- Enable diagnostics
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = true,
--     signs = true,
--     update_in_insert = true,
--   }
-- )
-- -- Enable rust_analyzer
-- nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })
--
-- -- Enable pyright
-- nvim_lsp.pyright.setup({ on_attach=on_attach })
--
-- -- Enable diagnostics
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = true,
--     signs = true,
--     update_in_insert = true,
--   }
-- )
--
-- local opts = {
--     tools = {
--         autoSetHints = true,
--         hover_with_actions = true,
--         runnables = {
--             use_telescope = true
--         },
--         inlay_hints = {
--             show_parameter_hints = false,
--             parameter_hints_prefix = "",
--             other_hints_prefix = "",
--         },
--     },
--
--     -- all the opts to send to nvim-lspconfig
--     -- these override the defaults set by rust-tools.nvim
--     -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
--     server = {
--         -- on_attach is a callback called when the language server attachs to the buffer
--         -- on_attach = on_attach,
--         settings = {
--             -- to enable rust-analyzer settings visit:
--             -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
--             ["rust-analyzer"] = {
--                 -- enable clippy on save
--                 checkOnSave = {
--                     command = "clippy"
--                 },
--             }
--         }
--     },
-- }
--
-- require('rust-tools').setup(opts)
