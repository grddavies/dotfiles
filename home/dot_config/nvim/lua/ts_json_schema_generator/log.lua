local M = {}

--- Logging utility
---@param funcname string: name of the function for context
---@param opts table: opts.level string, opts.msg string, opts.once bool
function M.log(funcname, opts)
  opts.once = vim.F.if_nil(opts.once, false)
  local level = vim.log.levels[opts.level] or vim.log.levels.INFO
  if not level then
    error("Invalid error level", 2)
  end
  local notify_fn = opts.once and vim.notify_once or vim.notify
  notify_fn(string.format("[ts-json-schema-generator.%s]: %s", funcname, opts.msg), level, {
    title = "ts-json-schema-generator",
  })
end

--- Log info
---@param funcname string: name of the function for context
---@param opts table: string, opts.msg string, opts.once bool
function M.info(funcname, opts)
  opts.level = "INFO"
  M.log(funcname, opts)
end

--- Log an error
---@param funcname string: name of the function for context
---@param opts table: string, opts.msg string, opts.once bool
function M.error(funcname, opts)
  opts.level = "ERROR"
  M.log(funcname, opts)
end

--- Log a warning
---@param funcname string: name of the function for context
---@param opts table: string, opts.msg string, opts.once bool
function M.warn(funcname, opts)
  opts.level = "WARN"
  M.log(funcname, opts)
end

return M
