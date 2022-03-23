local on_attach = function(client, bufnr)
	local opts = { noremap=true, silent=true }

	if client.resolved_capabilities.document_formatting then
	  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'g,', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  -- TODO: use new autocmd
  vim.cmd([[
    augroup format
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
    augroup end
  ]])
  end

end

return {
  setup = function(lsp)
    lsp.efm.setup {
      on_attach = on_attach,
      init_options = {documentFormatting = true},
       settings = {
	       rootMarkers = {".git/"},
	       languages = {
		       bzl = {
			       { lintCommand = "bazel run --ui_event_filters=-info,-stdout,-stderr --noshow_progress @com_github_bazelbuild_buildtools//buildifier:buildifier -- -lint=warn -mode=check -warnings=-function-docstring-args,-module-docstring,-function-docstring -path ${INPUT}",
lintIgnoreExitCode = true,
lintStdin = true,
formatCommand = "bazel run --ui_event_filters=-info,-stdout,-stderr --noshow_progress @com_github_bazelbuild_buildtools//buildifier:buildifier -- -mode=fix -path ${INPUT}",
formatStdin = true, },
		       },
	       },
       },
    }
  end
}
