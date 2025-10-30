vim.api.nvim_create_autocmd("User", {
  pattern = "LazyLoad",
  callback = function(event)
    if event.data == "nvim-lspconfig" then
      -- Create keymaps to toggle harper-ls
      Snacks.toggle
        .new({
          id = "harper",
          name = "Harper  ",
          get = function()
            local clients = vim.lsp.get_clients({ name = "harper_ls" })

            if #clients == 0 then
              return false
            end

            return not clients[1]:is_stopped()
          end,
          set = function(state)
            if state then
              vim.cmd("LspStart harper_ls")
            else
              vim.cmd("LspStop harper_ls")
            end
          end,
        })
        :map("<leader>uH")
    end
  end,
})

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        harper_ls = {
          -- Disabled by default
          enabled = false,
          settings = {
            ["harper-ls"] = {
              diagnosticSeverity = "hint",
              dialect = "British",
              linters = {
                SentenceCapitalization = false,
                LongSentences = false,
              },
            },
          },
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "harper_ls" },
      automatic_enable = {
        exclude = {
          "harper_ls",
        },
      },
    },
  },
}
