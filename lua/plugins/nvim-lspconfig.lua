local on_attach = require("util.lsp").on_attach

local config = function()
	require("neoconf").setup({})
	-- local cmp_nvim_lsp = require("nvim_cmp")

	local lspconfig = require("lspconfig")

	local signs = {
		Error = " ",
		Warn = " ",
		Hint = "",
		Info = "",
	}
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	-- local capabilities = cmp_nvim_lsp.default_capabilities()

	-- python
	lspconfig.pyright.setup({
		-- capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

	-- lua
	lspconfig.lua_ls.setup({
		-- capabilities = capabilities,
		on_attach = on_attach,
		settings = { -- custom settings for lua
			Lua = {
				diagnositcs = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua",
					},
				},
			},
		},
	})

	lspconfig.solidity_ls.setup({
		-- capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "solidity" },
		root_dir = lspconfig.util.root_pattern("hardhat.config.*", ".git"),
	})

	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")
	local solhint = require("efmls-configs.linters.solhint")
	local prettier = require("efmls-configs.formatters.prettier")

	-- configure efm server
	lspconfig.efm.setup({
		filetypes = {
			"lua",
			"python",
			"solidity",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
				python = { flake8, black },
				solidity = { solhint, prettier },
			},
		},
	})

	-- Format on Save
	local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = lsp_fmt_group,
		callback = function()
			local efm = vim.lsp.get_active_clients({ name = "efm" })

			if vim.tbl_isempty(efm) then
				return
			end

			vim.lsp.buf.format({ name = "efm" })
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
	},
}
