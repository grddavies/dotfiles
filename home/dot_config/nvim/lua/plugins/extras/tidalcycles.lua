return {
  "grddavies/tidal.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  branch = "rewrite",
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
