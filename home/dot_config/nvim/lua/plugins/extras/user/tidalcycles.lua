return {
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
}
