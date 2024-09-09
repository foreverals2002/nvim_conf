local opts = {
  ensure_installed = {
    "efm",
    "lua_ls",
    "solidity_ls_nomicfoundation",
  },
  automatic_installation = true,
}

return {
  "williamboman/mason-lspconfig.nvim",
  opts = opts,
  event = "BufReadPre",
  dependencies = "williamboman/mason.nvim",
}
