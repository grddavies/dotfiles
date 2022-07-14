-- Define functions that set which whitespace characters to display
local chars = {
  s = {space = '·'},
  t = {tab = '-->'}, -- '→'
  x = {extends = '…'},
  p = {precedes = '…'},
  n = {nbsp = '␣'},
  e = {eol = '↲'},
  a = {trail = '•'},
  -- TODO: conceal, lead, multispace
}

local function set_listchars(str)
  vim.opt.listchars = {}
  str:gsub('.', function(c) vim.opt.listchars:append(chars[c]) end)
end

local function ShowChars(arg)
  vim.o.list = arg.args ~= ''
  set_listchars(string.lower(arg.args))
end

vim.api.nvim_create_user_command( "ShowChars", ShowChars, {
  nargs = 1,
  complete = function(_, _, _) return { "stxpnea" } end,
})

-- set default listchars
set_listchars('stxpn')
