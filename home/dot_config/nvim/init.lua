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
