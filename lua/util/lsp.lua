local keymap = vim.keymap

local M = {}

-- set keymaps on the active lsp server
M.on_attach = function(client, bufnr) 
		-- keybind options
		local opts = { noremap = true, silent = true, buffer = bufnr }

		-- set keybinds
		keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
		keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- go to definition
		keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- peak definition
		keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to definition
		keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- go to definition
		keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- see available code actions
		keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- smart rename
		keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
		keymap.set("n", "<leader>pd", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to prev diagnostic in buffer
		keymap.set("n", "<leader>nd", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
		keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show  diagnostics for line
		keymap.set("n", "<leader>lo", "<cmd>LSoutlineToggle<CR>", opts) -- show workspace diagnostics
  
  if client.name == 'pyright' then
    keymap.set("n", "<leader>oi", "<cmd>PyrightOrganizeImports<CR>", opts)
  end
end

return M
