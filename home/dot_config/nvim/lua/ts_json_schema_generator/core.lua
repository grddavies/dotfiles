local M = {}

local log = require("ts_json_schema_generator.log")

function M.generate_schema(symbol, opts)
  opts = opts or {}
  local Job = require("plenary.job")

  local bufname = vim.api.nvim_buf_get_name(0)
  local cmd = opts.cmd or "ts-json-schema-generator"
  local args = { "--path", bufname, "--type", symbol }

  if not opts.type_check then
    table.insert(args, 5, "--no-type-check")
  end

  local stdout = {}

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
        vim.api.nvim_buf_set_option(bufnr, "filetype", "json")
        vim.api.nvim_buf_set_option(bufnr, "bufhidden", "hide")
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

local get_filename_fn = function()
  local bufnr_name_cache = {}
  return function(bufnr)
    bufnr = vim.F.if_nil(bufnr, 0)
    local c = bufnr_name_cache[bufnr]
    if c then
      return c
    end

    local n = vim.api.nvim_buf_get_name(bufnr)
    bufnr_name_cache[bufnr] = n
    return n
  end
end

local function entry_maker(opts)
  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()

  local display_items = {
    { remaining = true },
  }

  if opts.show_line then
    table.insert(display_items, 1, { width = 6 })
  end

  local displayer = require("telescope.pickers.entry_display").create({
    separator = " ",
    items = display_items,
  })

  local make_display = function(entry)
    local display_columns = {
      entry.text,
    }
    if opts.show_line then
      table.insert(display_columns, 1, { entry.lnum .. ":" .. entry.col, "TelescopeResultsLineNr" })
    end

    return displayer(display_columns)
  end

  local get_filename = get_filename_fn()
  return function(entry)
    local start_row, start_col, end_row, _ = vim.treesitter.get_node_range(entry.node)
    local node_text = vim.treesitter.get_node_text(entry.node, bufnr)
    return require("telescope.make_entry").set_default_entry_mt({
      value = entry.node,
      kind = entry.kind,
      ordinal = node_text .. " " .. (entry.kind or "unknown"),
      display = make_display,

      node_text = node_text,

      filename = get_filename(bufnr),
      -- need to add one since the previewer substacts one
      lnum = start_row + 1,
      col = start_col,
      text = node_text,
      start = start_row,
      finish = end_row,
    }, opts)
  end
end

function M.find_types(opts)
  local ok, parser = pcall(vim.treesitter.get_parser, opts.bufnr or 0, "typescript")
  if not ok then
    log.error("find_types", { msg = "No parser available - Install with `TSInstall typescript`" })
    return
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
  opts.show_line = vim.F.if_nil(opts.show_line, true)

  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local conf = require("telescope.config").values

  local results = M.find_types(opts)

  opts.show_line = true
  pickers
    .new(opts, {
      prompt_title = "Select a symbol to generate a JSON schema for",
      finder = finders.new_table({
        results = results,
        entry_maker = opts.entry_maker or entry_maker(opts),
      }),
      previewer = conf.grep_previewer(opts),
      sorter = conf.prefilter_sorter({
        tag = "kind",
        sorter = conf.generic_sorter(opts),
      }),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          M.generate_schema(selection.text)
        end)
        return true
      end,
    })
    :find()
end

return M
