return {
  -- Setup LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {
          keys = {
            {
              "<leader>cP",
              function()
                local buf_name = vim.api.nvim_buf_get_name(0)
                LazyVim.lsp.execute({
                  command = "tinymist.pinMain",
                  arguments = { buf_name },
                })
              end,
              desc = "Pin main file",
            },
          },
          single_file_support = true, -- Fixes LSP attachment in non-Git directories
          settings = {
            formatterMode = "typstyle",
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        typst = { "typstyle", lsp_format = "prefer" },
      },
    },
  },
  {
    "chomosuke/typst-preview.nvim",
    cmd = { "TypstPreview", "TypstPreviewToggle", "TypstPreviewUpdate" },
    version = "1.*",
    keys = {
      {
        "<leader>cp",
        ft = "typst",
        "<cmd>TypstPreviewToggle<cr>",
        desc = "Toggle Typst Preview",
      },
    },
    opts = {
      dependencies_bin = {
        tinymist = "tinymist",
      },
    },
  },

  {
    "folke/ts-comments.nvim",
    opts = {
      lang = {
        typst = { "// %s", "/* %s */" },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typst" })
      end
    end,
  },
}
