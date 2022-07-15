-- Define functions that set which whitespace characters to display
local chars = {
  a = {trail = '·'}, -- '•'
  s = {space = '·'},
  t = {tab = '-->'}, -- '→'
  x = {extends = '…'},
  p = {precedes = '…'},
  n = {nbsp = '␣'},
  e = {eol = '↲'},
  -- TODO: conceal, lead, multispace
}

local function set_listchars(str)
  vim.opt.listchars = {}
  str:gsub('.', function(c) vim.opt.listchars:append(chars[c]) end)
end

local function ShowChars(arg)
  local show = arg.args ~= 'none'
  if show then
    set_listchars(string.lower(arg.args))
  end
  vim.opt.list = show
end

vim.api.nvim_create_user_command( "ShowChars", ShowChars, {
  nargs = 1,
  complete = function(_, _, _) return { "astxpne", 'none' } end,
})

-- set default listchars
set_listchars('atxpn')
