local keymap_prefix = "ga"

return {
  {
    -- Text case change and case-smart query replace
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup({
        default_keymappings_enabled = false,
        prefix = keymap_prefix,
      })

      local keys = {
        { method_name = "to_constant_case", quick_replace = "n", operator = "on", lsp_rename = "N" },
        { method_name = "to_camel_case", quick_replace = "c", operator = "oc", lsp_rename = "C" },
        { method_name = "to_snake_case", quick_replace = "s", operator = "os", lsp_rename = "S" },
        { method_name = "to_dash_case", quick_replace = "d", operator = "od", lsp_rename = "D" },
        { method_name = "to_pascal_case", quick_replace = "p", operator = "op", lsp_rename = "P" },
        { method_name = "to_upper_case", quick_replace = "u", operator = "ou", lsp_rename = "U" },
        { method_name = "to_lower_case", quick_replace = "l", operator = "ol", lsp_rename = "L" },
        { method_name = "to_title_case", quick_replace = "t", operator = "ot", lsp_rename = "T" },
        { method_name = "to_dot_case", quick_replace = ".", operator = "o.", lsp_rename = ">" },
      }

      local plugin = require("textcase.plugin.plugin")
      local presets = require("textcase.plugin.presets")
      local api = require("textcase.plugin.api")

      for _, keymapping_definition in ipairs(keys) do
        plugin.register_keybindings(presets.options.prefix, api[keymapping_definition.method_name], {
          prefix = presets.options.prefix,
          quick_replace = keymapping_definition.quick_replace,
          operator = keymapping_definition.operator,
          lsp_rename = keymapping_definition.lsp_rename,
        })
      end
      -- No telescope in vscode
      local telescope_ok, telescope = pcall(require, "telescope")
      if telescope_ok then
        telescope.load_extension("textcase")
      end
    end,
    event = { "BufReadPost" },
    vscode = true,
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        [keymap_prefix] = { name = "+change-case" },
      },
    },
  },
}
