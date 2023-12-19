-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Clear Registers with user command
vim.api.nvim_create_user_command("ClearReg", function(args)
  for reg in string.gmatch(args.args, ".") do
    vim.fn.setreg(reg, {})
  end
end, {
  nargs = 1,
})

local function generate_schema(symbol)
  local curbuff = vim.api.nvim_buf_get_name(0)
  local cmd_path = "ts-json-schema-generator"

  local command = string.format("%s --path '%s' --type '%s' -f ./tsconfig.json", cmd_path, curbuff, symbol)

  local output = vim.fn.system(command)

  if vim.v.shell_error ~= 0 then
    vim.notify(output, vim.log.levels.WARN)
  else
    -- Create a new buffer and set its content to the command output
    local bufnr = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(output, "\n"))
    vim.api.nvim_set_current_buf(bufnr)
    vim.api.nvim_buf_set_name(bufnr, symbol .. ".schema.json")
    vim.api.nvim_buf_set_option(bufnr, "filetype", "json")
    vim.notify("Generated schema for: " .. symbol, vim.log.levels.INFO)
  end
end

vim.api.nvim_create_user_command("GenerateJSONSchema", function(opts)
  opts = opts or {}
  local bufnr = 0
  local params = vim.lsp.util.make_position_params()
  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local conf = require("telescope.config").values
  vim.lsp.buf_request(bufnr, "textDocument/documentSymbol", params, function(err, result, context, config)
    if err then
      vim.api.nvim_err_writeln("Error when finding document symbols: " .. err.message)
      return
    end

    if not result or vim.tbl_isempty(result) then
      vim.notify("No results from textDocument/documentSymbol")
      return
    end

    local filtered_symbols = {}
    for _, symbol in ipairs(result) do
      -- Check for classes, type definitions, and interfaces
      if
        symbol.kind == vim.lsp.protocol.SymbolKind.Class
        or symbol.kind == vim.lsp.protocol.SymbolKind.Interface
        or symbol.kind == vim.lsp.protocol.SymbolKind.TypeParameter
        or symbol.kind == vim.lsp.protocol.SymbolKind.Struct
        or symbol.kind == vim.lsp.protocol.SymbolKind.Variable -- To deal with tsserver being s**t
      then
        table.insert(filtered_symbols, symbol)
      end
    end

    pickers
      .new(opts, {
        prompt_title = "Generate JSON schema",
        finder = finders.new_table({
          results = filtered_symbols,
          entry_maker = function(symbol)
            return {
              value = symbol,
              display = symbol.name,
              ordinal = symbol.name,
            }
          end,
        }),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            generate_schema(selection.value.name)
          end)
          return true
        end,
      })
      :find()
  end)
end, {})
