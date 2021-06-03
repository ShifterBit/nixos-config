
require('helpers')

--------------------------
---------- LSP -----------
--------------------------

local lsp_opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', lsp_opts)



-----------------------------
-------- Naviagation --------
-----------------------------
local fzf_opts = { noremap= true, silent = true }

vim.api.nvim_set_keymap('n', '<leader><leader>', ':Files<CR>', fzf_opts)
vim.api.nvim_set_keymap('n', '<leader>ff', ':Files<CR>', fzf_opts)
vim.api.nvim_set_keymap('n', '<leader>fr', ':Rg<CR>',  fzf_opts)

-----------------------------
-------- LSP FZF --------
-----------------------------

vim.api.nvim_set_keymap('n', '<leader>fcs', ':DocumentSymbols<CR>', fzf_opts)
vim.api.nvim_set_keymap('n', '<leader>fcS', ':WorkspaceSymbols<CR>', fzf_opts)
vim.api.nvim_set_keymap('n', '<leader>fcr', ':References<CR>', fzf_opts)
vim.api.nvim_set_keymap('n', '<leader>fca', ':CodeActions<CR>', fzf_opts)
vim.api.nvim_set_keymap('n', '<leader>fcA', ':RangeCodeActions<CR>', fzf_opts)

----------------------------
-------- Completion --------
----------------------------
local completion_opts = { expr = true, silent = true, noremap = true }
vim.g.lexima_no_default_rules = true
vim.cmd('call lexima#set_default_rules()')
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', completion_opts)
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', completion_opts)
vim.cmd('inoremap <silent><expr> <C-Space> compe#complete()')
vim.cmd('inoremap <silent><expr> <CR>      compe#confirm(lexima#expand("<LT>CR>", "i"))')

------------------------
------- Buffers --------
------------------------
vim.api.nvim_set_keymap('n', '<C-j>', ':bnext<CR>', lsp_opts)
vim.api.nvim_set_keymap('n', '<C-k>', ':bprev<CR>', lsp_opts)
