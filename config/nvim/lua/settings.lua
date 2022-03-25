-- Use a solarized light colorscheme
vim.opt.background = "light"
vim.cmd "colorscheme NeoSolarized"

--autocmd Filetype c,cpp,proto set comments^=:///
--set wrap textwidth=72 ts=4 sw=4 et ai si nocp
-- set modeline
-- " Doxygen comments
-- autocmd Filetype c,cpp set comments^=:///
--
-- "Swap '` as ` is more useful in mark-locating
-- nnoremap ' `
-- nnoremap ` '
-- "Default leader is \ which is inconvenient
-- let mapleader = ","
-- "Increase the command/search history
-- "set history=100000
--
-- " XXXX
-- runtime plugin/matchit.vim
--
-- "Shell-like command completion
-- set wildmode=list:longest
-- "Smart (usually case-insensitive) searching
-- set ignorecase
-- set smartcase
-- "When scrolling, include context
-- set scrolloff=5
-- "Single-step scroll faster
-- nnoremap <C-e> 5<C-e>
-- nnoremap <C-y> 5<C-y>
-- "Store swap files centrally in ~/.vimtmp
-- set directory=~/.vim/tmp
-- "Highlight and incremental search
-- set incsearch
-- nmap <silent><leader>n :silent :nohlsearch<CR>
-- "Highlight trailing whitespace with ,s
-- "set listchars=tab:>-,trail:·,eol:$
-- nmap <silent><leader>s :set nolist!<CR>
-- "Shorten some messages
-- set shortmess=atI
-- "Reindent entire file
-- nmap <F10> 1G=G
-- imap <F10> <ESC>1G=Ga
--
--
-- set spell
-- set spelllang=en
--
-- set tabpagemax=40
-- set foldenable
-- set fdm=syntax
-- nnoremap <space> za
-- set wrap textwidth=72 ts=4 sw=4 et ai si nocp
-- set grepprg=grep\ -nH\ $*
-- set nocindent
-- let g:tex_flavor='latex'
-- let g:Tex_SmartKeyQuote=0
--
-- set nu
-- set t_Co=256
-- let s:solarized_termtrans = 1
-- let g:solarized_termcolors = 256
-- colorscheme solarized
--
-- highlight SpellBad cterm=underline ctermfg=White ctermbg=NONE
--
--
-- highlight ExtraWhitespace ctermbg=red guibg=red
-- " Show trailing whitespace and spaces before a tab:
-- match ExtraWhitespace /\s\+$\| \+\ze\t/
-- " Show tabs that are not at the start of a line:
-- match ExtraWhitespace /[^\t]\zs\t\+/
-- " Show spaces used for indenting (so you use only tabs for indenting).
-- " match ExtraWhitespace /^\t*\zs \+/
-- " Switch off :match highlighting.
-- " match
--
-- "setlocal foldmethod=expr foldexpr=DiffFold(v:lnum)
-- "function! DiffFold(lnum)
-- "  let line = getline(a:lnum)
-- "  if line =~ '^\(diff\|---\|+++\|@@\) '
-- "    return 1
-- "  elseif line[0] =~ '[-+ ]'
-- "    return 2
-- "  else
-- "    return 0
-- "  endif
-- "endfunction
--
-- augroup ProjectSetup
--     au BufRead,BufEnter /export/home/jeffga/git/genome_nova/*/*.{cc,h} set makeprg=./project_scripts/build
-- augroup END
-- " Collection of common configurations for the Nvim LSP client
-- Plug 'neovim/nvim-lspconfig'
--
-- " Extensions to built-in LSP, for example, providing type inlay hints
-- Plug 'nvim-lua/lsp_extensions.nvim'
--
-- Plug 'nvim-lua/popup.nvim'
-- Plug 'nvim-lua/plenary.nvim'
-- Plug 'nvim-telescope/telescope.nvim'
-- Plug 'mfussenegger/nvim-dap'
--
-- "
-- " Autocompletion framework for built-in LSP
-- Plug 'nvim-lua/completion-nvim'
--
-- Plug 'overcache/NeoSolarized'
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
--
-- " Set completeopt to have a better completion experience
-- " :help completeopt
-- " menuone: popup even when there's only one match
-- " noinsert: Do not insert text until a selection is made
-- " noselect: Do not select, force user to select one from the menu
-- set completeopt=menuone,noinsert,noselect
--
-- " Avoid showing extra messages when using completion
-- set shortmess+=c
--
-- -- function to attach completion when setting up lsp
-- local on_attach = function(client)
--     require'completion'.on_attach(client)
-- end
--
-- -- Enable rust_analyzer
-- nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })
--
-- -- Enable clangd
-- nvim_lsp.clangd.setup({ on_attach=on_attach })
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
-- EOF
--
-- " Code navigation shortcuts
-- " as found in :help lsp
-- nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
-- nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
-- nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
-- nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
-- nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
-- nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
-- nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
-- nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
-- nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
--
-- " Quick-fix
-- nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
--
--
-- "set termguicolors
-- colorscheme NeoSolarized
--
-- nnoremap <silent> ff <cmd>lua vim.lsp.buf.formatting()<CR>
--
-- autocmd Filetype c,cpp,proto set comments^=:///
--
--
-- " Find files using Telescope command-line sugar.
-- nnoremap <leader>ff <cmd>Telescope find_files<cr>
-- nnoremap <leader>fg <cmd>Telescope live_grep<cr>
-- nnoremap <leader>fb <cmd>Telescope buffers<cr>
-- nnoremap <leader>fh <cmd>Telescope help_tags<cr>
--
-- " Setup Completion
-- " See https://github.com/hrsh7th/nvim-cmp#basic-configuration
-- lua <<EOF
-- local cmp = require'cmp'
-- cmp.setup({
--   snippet = {
--     expand = function(args)
--         vim.fn["vsnip#anonymous"](args.body)
--     end,
--   },
--   mapping = {
--     ['<C-p>'] = cmp.mapping.select_prev_item(),
--     ['<C-n>'] = cmp.mapping.select_next_item(),
--     -- Add tab support
--     ['<S-Tab>'] = cmp.mapping.select_prev_item(),
--     ['<Tab>'] = cmp.mapping.select_next_item(),
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.close(),
--     ['<CR>'] = cmp.mapping.confirm({
--       behavior = cmp.ConfirmBehavior.Insert,
--       select = true,
--     })
--   },
--
--   -- Installed sources
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'vsnip' },
--     { name = 'path' },
--     { name = 'buffer' },
--   },
-- })
-- EOF
--
-- " have a fixed column for the diagnostics to appear in
-- " this removes the jitter when warnings/errors flow in
-- set signcolumn=yes
--
-- " Set updatetime for CursorHold
-- " 300ms of no cursor movement to trigger CursorHold
-- set updatetime=300
-- " Show diagnostic popup on cursor hover
-- " autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
--
-- " Goto previous/next diagnostic warning/error
-- nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
-- nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
-- Plug 'nvim-lua/popup.nvim'
-- Plug 'nvim-lua/plenary.nvim'
-- Plug 'nvim-telescope/telescope.nvim'
-- Plug 'nvim-lua/completion-nvim'
--
-- " Set completeopt to have a better completion experience
-- " :help completeopt
-- " menuone: popup even when there's only one match
-- " noinsert: Do not insert text until a selection is made
-- " noselect: Do not select, force user to select one from the menu
-- set completeopt=menuone,noinsert,noselect
--
-- " Avoid showing extra messages when using completion
-- set shortmess+=c
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
-- "set termguicolors
--
-- autocmd Filetype c,cpp,proto set comments^=:///
--
-- " Find files using Telescope command-line sugar.
-- nnoremap <leader>ff <cmd>Telescope find_files<cr>
-- nnoremap <leader>fg <cmd>Telescope live_grep<cr>
-- nnoremap <leader>fb <cmd>Telescope buffers<cr>
-- nnoremap <leader>fh <cmd>Telescope help_tags<cr>
