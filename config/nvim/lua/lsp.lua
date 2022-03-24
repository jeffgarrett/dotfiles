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
