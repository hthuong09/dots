local loaded, treesitter = pcall(require, "nvim-treesitter.configs")
if not loaded then return end

treesitter.setup({
  ensure_installed = { "javascript", "typescript", "lua", "html" },
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }, -- JoosepAlviste/nvim-ts-context-commentstring
  -- rainbow = {
  --   enable = true,
  --   disable = { "html" },
  --   extended_mode = false,
  --   max_file_lines = nil,
  -- }, -- p00f/nvim-ts-rainbow
  autopairs = { enable = true }, -- windwp/nvim-autopairs
  -- autotag = { enable = true }, -- windwp/nvim-ts-autotag
  incremental_selection = { enable = true },
  -- indent = { enable = false }, -- lukas-reineke/indent-blankline.nvim
})

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
