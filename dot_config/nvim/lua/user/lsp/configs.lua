local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  vim.notify("Could not load package 'nvim-lsp-installer'")
	return
end

local lspconfig = require("lspconfig")
local handlers = require("user.lsp.handlers")
local servers = { "jsonls", "sumneko_lua", "pyright" }


lsp_installer.setup({
	ensure_installed = servers,
})


for _, server in pairs(servers) do
	local opts = {
		on_attach = handlers.on_attach,
		capabilities = handlers.capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end
