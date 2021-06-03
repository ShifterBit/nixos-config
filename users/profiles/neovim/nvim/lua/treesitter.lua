local treesitter = require ('nvim-treesitter.configs')
----------------------------
-------- Treesitter --------
----------------------------
treesitter.setup {
  ensure_installed = "all",
  indent = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
}

