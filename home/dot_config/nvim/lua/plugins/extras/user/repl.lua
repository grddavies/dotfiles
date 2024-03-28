return {
  {
    -- REPL launcher
    "Vigemus/iron.nvim",
    -- Annoying reimplementation of the plugin defaults to override descriptions
    keys = {
      {
        "<leader>rsm",
        function()
          require("iron.core").run_motion("send_motion")
        end,
        desc = "Send motion",
      },
      {
        "<S-CR>",
        function()
          require("iron.core").send_line()
        end,
        desc = "Send line",
      },
      {
        "<leader>rsb",
        function()
          require("iron.core").send_file()
        end,
        desc = "Send buffer",
      },
      {
        "<leader>rsc",
        function()
          require("iron.core").send_until_cursor()
        end,
        desc = "Send up to cursor",
      },
      {
        "<S-CR>",
        function()
          require("iron.core").visual_send()
        end,
        mode = "v",
        desc = "Send visual selection",
      },
      {
        "<leader>rc",
        function()
          require("iron.core").send(nil, string.char(03))
        end,
        mode = { "n", "v" },
        desc = "Interrupt REPL",
      },
      {
        "<leader>rl",
        function()
          require("iron.core").send(nil, string.char(12))
        end,
        mode = { "n", "v" },
        desc = "Clear REPL",
      },
      {
        "<leader>rq",
        function()
          require("iron.core").close_repl()
        end,
        mode = { "n", "v" },
        desc = "Quit REPL",
      },
    },
    main = "iron.core",
    opts = {
      config = {
        repl_open_cmd = "vsplit",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>r"] = { name = "+repl" },
        ["<leader>rs"] = { name = "+repl-send" },
      },
    },
  },
}
