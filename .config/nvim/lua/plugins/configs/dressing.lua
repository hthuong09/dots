local loaded, dressing = pcall(require, "dressing")
if not loaded then
  return
end
dressing.setup {
  input = {
    enabled = true,
    default_prompt = "➤ ",
    winhighlight = "Normal:Normal,NormalNC:Normal",
  },
  select = {
    enabled = true,
    backend = { "telescope", "builtin" },
    builtin = { winhighlight = "Normal:Normal,NormalNC:Normal" },
    telescope = {
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.3,
        height = 0.25,
      },
    },
  },
}
