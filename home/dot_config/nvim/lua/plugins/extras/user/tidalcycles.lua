return {
  {
    "grddavies/tidal.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = { "BufRead *.tidal", "BufEnter *.tidal" },
    branch = "main",
    opts = {
      boot = {
        tidal = {
          file = "$XDG_CONFIG_HOME/tidal/hs/BootTidal.hs",
        },
        sclang = {
          file = "$XDG_CONFIG_HOME/tidal/startdirt.scd",
          enabled = true,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        hls = {
          mason = false,
          -- TODO: Just extend this
          filetypes = { "haskell", "lhaskell", "tidal" },
        },
      },
      setup = {
        hls = function()
          LazyVim.lsp.on_attach(function(client, _)
            if client.name == "hls" then
              -- Fix to remove highlight capability as there's an annoying error
              client.server_capabilities.documentHighlightProvider = false
            end
          end)
        end,
      },
    },
  },
}
