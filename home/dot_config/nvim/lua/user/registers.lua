local function clear_registers(args)
  for reg in string.gmatch(args.args, ".") do
    vim.fn.setreg(reg, {})
  end
end

vim.api.nvim_create_user_command("ClearReg", clear_registers, {
  nargs = 1
})
