local loaded, notify = pcall(require, "notify")
if not loaded then
  return
end
notify.setup { stages = "fade" }
vim.notify = notify
