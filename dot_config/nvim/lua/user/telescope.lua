local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  vim.notify("Could not load 'telescope'")
  return
end

