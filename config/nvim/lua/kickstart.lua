require("packer").startup(function(use)
  use "tpope/vim-fugitive" -- Git commands in nvim
  use "tpope/vim-rhubarb" -- Fugitive-companion to interact with github
  use "ludovicchabant/vim-gutentags" -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  use { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  -- Add indentation guides even on blank lines
  use "lukas-reineke/indent-blankline.nvim"
  -- Add git related info in the signs columns and popups
  use { "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use "hrsh7th/nvim-cmp" -- Autocompletion plugin
  use "hrsh7th/cmp-nvim-lsp"
  use "saadparwaiz1/cmp_luasnip"
  use "L3MON4D3/LuaSnip" -- Snippets plugin
end)

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

--Enable Comment.nvim
require("Comment").setup()

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap for dealing with word wrap
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require("gitsigns").setup {
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
}

-- Telescope
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

-- Enable telescope fzf native
require("telescope").load_extension "fzf"

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

-- Diagnostic keymaps
vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", { noremap = true, silent = true })

-- LSP settings
local lspconfig = require "lspconfig"
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>so",
    [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
    opts
  )
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Enable the following language servers
local servers = { "clangd", "rust_analyzer", "pyright", "tsserver" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Example custom server
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
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

-- luasnip setup
local luasnip = require "luasnip"

-- nvim-cmp setup
local cmp = require "cmp"
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
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

--autocmd Filetype c,cpp,proto set comments^=:///
--set wrap textwidth=72 ts=4 sw=4 et si nocp
-- set modeline
-- " Doxygen comments
--
-- "Swap '` as ` is more useful in mark-locating
-- nnoremap ' `
-- nnoremap ` '
-- "Default leader is \ which is inconvenient
-- let mapleader = ","
-- "Increase the command/search history
-- "set history=100000
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
-- set spell
-- set spelllang=en
--
-- set tabpagemax=40
-- set foldenable
-- set fdm=syntax
-- nnoremap <space> za
-- set grepprg=grep\ -nH\ $*
-- set nocindent
--
-- highlight SpellBad cterm=underline ctermfg=White ctermbg=NONE
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
-- nnoremap <silent> ff <cmd>lua vim.lsp.buf.formatting()<CR>
--
-- autocmd Filetype c,cpp,proto set comments^=:///
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
--   -- Plugins can have post-install/update hooks
--   use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
--
--   -- Use dependency and run lua function after load
--   use {
--     'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
--     config = function() require('gitsigns').setup() end
--   }

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
