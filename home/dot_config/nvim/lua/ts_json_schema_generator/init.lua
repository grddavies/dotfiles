local M = {}
local core = require("ts_json_schema_generator.core")

function M.setup()
  local augroup = vim.api.nvim_create_augroup("ts_json_schema_generator", { clear = true })
  -- Set buffer commands
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = {
      "typescript",
      "typescriptreact",
    },
    callback = function(event)
      vim.api.nvim_buf_create_user_command(event.buf, "GenerateJsonSchema", function()
        core.picker({})
      end, {})
    end,
  })
end

return M
