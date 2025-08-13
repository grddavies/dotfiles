local M = {}

local log = require("ts_json_schema_generator.log")

function M.generate_schema(symbol, opts)
  opts = opts or {}
  local Job = require("plenary.job")

  local bufname = vim.api.nvim_buf_get_name(0)
  local cmd = opts.cmd or "ts-json-schema-generator"
  -- TODO: Smarter find tsconfig
  local args = { "--path", bufname, "--type", symbol, "--tsconfig", "tsconfig.json" }

  if not opts.type_check then
    table.insert(args, 5, "--no-type-check")
  end

  local stdout = {}

  -- Can this be handled by vim.schedule?
  Job:new({
    command = cmd,
    args = args,
    on_stdout = function(_, data)
      if data then
        table.insert(stdout, data)
      end
    end,
    on_stderr = function(_, data)
      if data then
        log.warn("Generate Schema", {
          msg = data,
        })
      end
    end,
    on_exit = vim.schedule_wrap(function(_, return_val)
      if return_val == 0 then
        local bufnr = vim.api.nvim_create_buf(true, false)
        vim.api.nvim_set_current_buf(bufnr)
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, stdout)
        vim.api.nvim_buf_set_name(bufnr, symbol .. ".schema.json")
        vim.api.nvim_set_option_value("filetype", "json", { buf = bufnr })
        vim.api.nvim_set_option_value("bufhidden", "hide", { buf = bufnr })
        log.info("Generate Schema", {
          msg = "Generated schema for: " .. symbol,
        })
      else
        log.error("Generate Schema", {
          msg = "Failed to generate schema for: " .. symbol,
        })
      end
    end),
  }):start()
end

--- Find types to generate a schema for in the current buffer
---@param opts any
---@return {kind: string, node: TSNode}
function M.find_types(opts)
  local ok, parser = pcall(vim.treesitter.get_parser, opts.bufnr or 0, "typescript")
  if not ok then
    log.error("find_types", { msg = "No parser available - Install with `TSInstall typescript`" })
    return {}
  end

  local tree = parser:parse()[1]
  local root = tree:root()

  -- TODO: Parse declaration body to pass to previewer
  local query = vim.treesitter.query.parse(
    "typescript",
    [[
      (export_statement
        declaration: [
          (
            type_alias_declaration
            name: (type_identifier) @type.name
          )
          (
            interface_declaration
            name: (type_identifier) @type.name
          )
          (
            enum_declaration
            name: (identifier) @type.name
          )
        ]
      )
    ]]
  )

  local results = {}

  for id, node in query:iter_captures(root, 0, root:start(), -1) do
    table.insert(results, {
      kind = query.captures[id],
      node = node,
    })
  end

  return results
end

function M.picker(opts)
  local results = M.find_types(opts)

  if vim.tbl_isempty(results) then
    log.info("picker", { msg = "No results found" })
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()

  local node_names = vim
    .iter(results)
    :map(function(item)
      return {
        name = vim.treesitter.get_node_text(item.node, bufnr),
      }
    end)
    :totable()

  -- TODO: make a picker-agnostic previewer
  vim.ui.select(node_names, {
    kind = "Class",
    prompts = "Select a type to generate a JSON schema for",
    format_item = function(item)
      return item.name
    end,
  }, function(choice)
    if choice == nil then
      error("missing choice", vim.log.levels.ERROR)
    end
    M.generate_schema(choice.name)
  end)
end

return M
