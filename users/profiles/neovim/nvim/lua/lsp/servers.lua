------------------------------------------
-------- Language Server Protocol --------
------------------------------------------
local lsp = require ('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-------- C/C++ --------
lsp.clangd.setup{
  capabilities = capabilities
  }
-------- Python --------
lsp.pyright.setup{
  capabilities = capabilities
  }
-------- Lua --------
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = "lua-language-server"
lsp.sumneko_lua.setup{
    capabilities = capabilities,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
      Lua = {
        runtime = {
              version = 'LuaJIT',
              -- Setup your lua path
              path = vim.split(package.path, ';'),
          },
        diagnostics = {
          globals = {'vim'},
        }, 
        workspace = {
          library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        }, 
      },
    },
  }
-------- Rust --------
lsp.rust_analyzer.setup{
  capabilities = capabilities
  }
-------- Haskell --------
lsp.hls.setup{
  capabilities = capabilities
  }
-------- Vue --------
lsp.vuels.setup{
  capabilities = capabilities
  }
-------- Typescript/Javascript --------
lsp.tsserver.setup{
  capabilities = capabilities
  }
-------- HTML/CSS --------
lsp.html.setup{
  capabilities = capabilities
  }
lsp.cssls.setup{
  capabilities = capabilities
  }
-------- JSON --------
lsp.jsonls.setup{
  capabilities = capabilities
  }
-------- Nix --------
lsp.rnix.setup{
  capabilities = capabilities
  }
-------- Bash --------
lsp.bashls.setup{
   capabilities = capabilities
  }
-------- Docker --------
lsp.dockerls.setup{
  capabilities = capabilities
  }
-------- YAML --------
lsp.yamlls.setup{
  capabilities = capabilities
  }

