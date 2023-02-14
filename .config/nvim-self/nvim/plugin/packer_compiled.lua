-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/tyson.nguyen/.cache/nvim-self/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/tyson.nguyen/.cache/nvim-self/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/tyson.nguyen/.cache/nvim-self/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/tyson.nguyen/.cache/nvim-self/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/tyson.nguyen/.cache/nvim-self/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n†\1\0\0\6\0\a\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\5\0006\3\0\0'\5\3\0B\3\2\0029\3\4\3B\3\1\2=\3\6\2B\0\2\1K\0\1\0\rpre_hook\1\0\0\20create_pre_hook7ts_context_commentstring.integrations.comment_nvim\nsetup\fComment\frequire\0" },
    load_after = {},
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    after = { "cmp_luasnip" },
    config = { "\27LJ\2\n…\1\0\0\3\0\t\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0006\1\4\0009\1\5\0019\1\6\1B\1\1\0028\0\1\0\15\0\0\0X\1\fÄ6\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\a\0\14\0\0\0X\0\5Ä6\0\0\0'\2\1\0B\0\2\0029\0\b\0B\0\1\1K\0\1\0\19unlink_current\16jump_active\25nvim_get_current_buf\bapi\bvim\18current_nodes\fsession\fluasnip\frequire˘\2\1\0\b\0\20\0(6\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\1Ä2\0 Ä5\2\3\0009\3\4\0019\3\5\3\18\5\2\0B\3\2\0016\3\1\0'\5\6\0B\3\2\0029\3\a\3B\3\1\0016\3\1\0'\5\6\0B\3\2\0029\3\a\0035\5\v\0006\6\b\0009\6\t\0069\6\n\6\14\0\6\0X\a\1Ä'\6\f\0=\6\r\5B\3\2\0016\3\b\0009\3\14\0039\3\15\3'\5\16\0005\6\18\0003\a\17\0=\a\19\6B\3\3\1K\0\1\0K\0\1\0\rcallback\1\0\0\0\16InsertLeave\24nvim_create_autocmd\bapi\npaths\5\1\0\0\21luasnippets_path\6g\bvim\14lazy_load luasnip.loaders.from_vscode\15set_config\vconfig\1\0\2\17updateevents\29TextChanged,TextChangedI\fhistory\2\fluasnip\frequire\npcall\0" },
    load_after = {},
    loaded = true,
    needs_bufread = true,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/opt/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  base46 = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27plugins.configs.base46\frequire\0" },
    loaded = true,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/start/base46",
    url = "https://github.com/hthuong09/base46"
  },
  cmp_luasnip = {
    after_files = { "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n†\2\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\20buftype_exclude\1\2\0\0\rterminal\21filetype_exclude\1\n\0\0\thelp\rterminal\nalpha\vpacker\flspinfo\20TelescopePrompt\21TelescopeResults\nmason\5\1\0\3\28show_first_indent_level\2#show_trailing_blankline_indent\1\23indentLine_enabled\3\1\nsetup\21indent_blankline\frequire\0" },
    loaded = true,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nì\6\0\0\6\0&\0;6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\15\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0004\5\0\0=\5\t\0044\5\0\0=\5\n\4=\4\v\0034\4\0\0=\4\f\0035\4\r\0=\4\14\3=\3\16\0025\3\18\0005\4\17\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\0035\4\28\0=\4\29\3=\3\30\0025\3\31\0004\4\0\0=\4\19\0034\4\0\0=\4\21\0035\4 \0=\4\23\0035\4!\0=\4\25\0034\4\0\0=\4\27\0034\4\0\0=\4\29\3=\3\"\0024\3\0\0=\3#\0024\3\0\0=\3\n\0024\3\0\0=\3$\0024\3\0\0=\3%\2B\0\2\1K\0\1\0\15extensions\20inactive_winbar\ftabline\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\1\2\0\0\rfilename\14lualine_b\1\4\0\0\vbranch\tdiff\16diagnostics\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\frefresh\1\0\3\ftabline\3Ë\a\vwinbar\3Ë\a\15statusline\3Ë\a\17ignore_focus\23disabled_filetypes\vwinbar\15statusline\1\0\0\23section_separators\1\0\2\tleft\bÓÇ∞\nright\bÓÇ≤\25component_separators\1\0\2\tleft\bÓÇ±\nright\bÓÇ≥\1\0\4\ntheme\tauto\18icons_enabled\2\17globalstatus\1\25always_divide_middle\2\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugins.configs.lsp\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/opt/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    after = { "mason-lspconfig.nvim" },
    config = { "\27LJ\2\n˛\2\0\0\4\0\n\0\0145\0\5\0005\1\1\0005\2\0\0=\2\2\0015\2\3\0=\2\4\1=\1\6\0006\1\a\0'\3\b\0B\1\2\0029\1\t\1\18\3\0\0B\1\2\1K\0\1\0\nsetup\nmason\frequire\aui\1\0\1\30max_concurrent_installers\3\n\fkeymaps\1\0\b\19install_server\6i\27check_outdated_servers\6C\25toggle_server_expand\t<CR>\21uninstall_server\6X\23update_all_servers\6U\25check_server_version\6c\24cancel_installation\n<C-c>\18update_server\6u\nicons\1\0\0\1\0\3\24package_uninstalled\t ÔÆä\20package_pending\tÔÜí \22package_installed\tÔò≤ \0" },
    loaded = true,
    only_config = true,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "LuaSnip" },
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugins.configs.cmp\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    after = { "mason-lspconfig.nvim" },
    config = { "\27LJ\2\n—\6\0\0\5\0\30\0@6\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\4\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0005\3\6\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0005\3\b\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\t\0005\3\n\0B\0\3\0016\0\0\0009\0\v\0009\0\f\0005\2\14\0005\3\r\0=\3\15\2B\0\2\0016\0\0\0009\0\16\0009\0\17\0006\1\0\0009\1\16\0019\1\19\0016\3\0\0009\3\16\0039\3\17\0039\3\20\0035\4\21\0B\1\3\2=\1\18\0006\0\0\0009\0\16\0009\0\17\0006\1\0\0009\1\16\0019\1\19\0016\3\0\0009\3\16\0039\3\17\0039\3\23\0035\4\24\0B\1\3\2=\1\22\0006\0\25\0'\2\26\0B\0\2\0029\0\27\0'\1\29\0=\1\28\0K\0\1\0\vsingle\vborder\20default_options\25lspconfig.ui.windows\frequire\1\0\3\rrelative\vcursor\14focusable\1\vborder\vsingle\19signature_help\31textDocument/signatureHelp\1\0\1\vborder\vsingle\nhover\twith\23textDocument/hover\rhandlers\blsp\17virtual_text\1\0\3\14underline\2\nsigns\2\21update_in_insert\1\1\0\1\vprefix\bÔëÖ\vconfig\15diagnostic\1\0\2\ttext\bÔ†¥\vtexthl\30LspDiagnosticsDefaultHint\23DiagnosticSignHint\1\0\2\ttext\bÔÅö\vtexthl%LspDiagnosticsDefaultInformation\30DiagnosticSignInformation\1\0\2\ttext\bÔÅ±\vtexthl!LspDiagnosticsDefaultWarning\26DiagnosticSignWarning\1\0\2\ttext\bÔôò\vtexthl\31LspDiagnosticsDefaultError\24DiagnosticSignError\16sign_define\afn\bvim\0" },
    loaded = true,
    only_config = true,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nä\3\0\0\4\0\17\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0025\3\t\0=\3\n\0025\3\v\0=\3\f\0025\3\r\0=\3\14\0025\3\15\0=\3\16\2B\0\2\1K\0\1\0\vindent\1\0\1\venable\2\26incremental_selection\1\0\1\venable\2\14autopairs\1\0\1\venable\2\26context_commentstring\1\0\2\venable\2\19enable_autocmd\1\14highlight\1\0\2\venable\2&additional_vim_regex_highlighting\1\19ignore_install\21ensure_installed\1\0\1\17sync_install\1\1\6\0\0\15javascript\15typescript\blua\thtml\bvim\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/tyson.nguyen/.local/share/nvim-self/nvim/site/pack/packer/opt/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^Comment"] = "Comment.nvim",
  ["^Comment%.api"] = "Comment.nvim",
  ["^nvim%-autopairs%.completion%.cmp"] = "nvim-autopairs",
  ["^plenary"] = "plenary.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: Comment.nvim
time([[Setup for Comment.nvim]], true)
try_loadstring("\27LJ\2\nS\0\0\3\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0009\0\4\0B\0\1\1K\0\1\0\fcurrent\rlinewise\vtoggle\16Comment.api\frequire‚\1\1\0\6\0\n\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0003\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0'\3\4\0'\4\b\0005\5\t\0B\0\5\1K\0\1\0\1\0\1\tdesc\18Comment blockR<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>\6v\1\0\1\tdesc\17Comment line\0\14<leader>/\6n\bset\vkeymap\bvim\0", "setup", "Comment.nvim")
time([[Setup for Comment.nvim]], false)
-- Setup for: nvim-autopairs
time([[Setup for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n¡\1\0\0\n\0\v\0\0206\0\0\0006\2\1\0'\3\2\0B\0\3\3\15\0\0\0X\2\rÄ9\2\3\1\18\4\2\0009\2\4\2'\5\5\0006\6\1\0'\b\6\0B\6\2\0029\6\a\0065\b\t\0005\t\b\0=\t\n\bB\6\2\0A\2\2\1K\0\1\0\rmap_char\1\0\0\1\0\1\btex\5\20on_confirm_done\"nvim-autopairs.completion.cmp\17confirm_done\aon\nevent\bcmp\frequire\npcall\0", "setup", "nvim-autopairs")
time([[Setup for nvim-autopairs]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugins.configs.cmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\n†\2\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\20buftype_exclude\1\2\0\0\rterminal\21filetype_exclude\1\n\0\0\thelp\rterminal\nalpha\vpacker\flspinfo\20TelescopePrompt\21TelescopeResults\nmason\5\1\0\3\28show_first_indent_level\2#show_trailing_blankline_indent\1\23indentLine_enabled\3\1\nsetup\21indent_blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nä\3\0\0\4\0\17\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0025\3\t\0=\3\n\0025\3\v\0=\3\f\0025\3\r\0=\3\14\0025\3\15\0=\3\16\2B\0\2\1K\0\1\0\vindent\1\0\1\venable\2\26incremental_selection\1\0\1\venable\2\14autopairs\1\0\1\venable\2\26context_commentstring\1\0\2\venable\2\19enable_autocmd\1\14highlight\1\0\2\venable\2&additional_vim_regex_highlighting\1\19ignore_install\21ensure_installed\1\0\1\17sync_install\1\1\6\0\0\15javascript\15typescript\blua\thtml\bvim\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\n˛\2\0\0\4\0\n\0\0145\0\5\0005\1\1\0005\2\0\0=\2\2\0015\2\3\0=\2\4\1=\1\6\0006\1\a\0'\3\b\0B\1\2\0029\1\t\1\18\3\0\0B\1\2\1K\0\1\0\nsetup\nmason\frequire\aui\1\0\1\30max_concurrent_installers\3\n\fkeymaps\1\0\b\19install_server\6i\27check_outdated_servers\6C\25toggle_server_expand\t<CR>\21uninstall_server\6X\23update_all_servers\6U\25check_server_version\6c\24cancel_installation\n<C-c>\18update_server\6u\nicons\1\0\0\1\0\3\24package_uninstalled\t ÔÆä\20package_pending\tÔÜí \22package_installed\tÔò≤ \0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n—\6\0\0\5\0\30\0@6\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\4\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0005\3\6\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0005\3\b\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\t\0005\3\n\0B\0\3\0016\0\0\0009\0\v\0009\0\f\0005\2\14\0005\3\r\0=\3\15\2B\0\2\0016\0\0\0009\0\16\0009\0\17\0006\1\0\0009\1\16\0019\1\19\0016\3\0\0009\3\16\0039\3\17\0039\3\20\0035\4\21\0B\1\3\2=\1\18\0006\0\0\0009\0\16\0009\0\17\0006\1\0\0009\1\16\0019\1\19\0016\3\0\0009\3\16\0039\3\17\0039\3\23\0035\4\24\0B\1\3\2=\1\22\0006\0\25\0'\2\26\0B\0\2\0029\0\27\0'\1\29\0=\1\28\0K\0\1\0\vsingle\vborder\20default_options\25lspconfig.ui.windows\frequire\1\0\3\rrelative\vcursor\14focusable\1\vborder\vsingle\19signature_help\31textDocument/signatureHelp\1\0\1\vborder\vsingle\nhover\twith\23textDocument/hover\rhandlers\blsp\17virtual_text\1\0\3\14underline\2\nsigns\2\21update_in_insert\1\1\0\1\vprefix\bÔëÖ\vconfig\15diagnostic\1\0\2\ttext\bÔ†¥\vtexthl\30LspDiagnosticsDefaultHint\23DiagnosticSignHint\1\0\2\ttext\bÔÅö\vtexthl%LspDiagnosticsDefaultInformation\30DiagnosticSignInformation\1\0\2\ttext\bÔÅ±\vtexthl!LspDiagnosticsDefaultWarning\26DiagnosticSignWarning\1\0\2\ttext\bÔôò\vtexthl\31LspDiagnosticsDefaultError\24DiagnosticSignError\16sign_define\afn\bvim\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nì\6\0\0\6\0&\0;6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\15\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0004\5\0\0=\5\t\0044\5\0\0=\5\n\4=\4\v\0034\4\0\0=\4\f\0035\4\r\0=\4\14\3=\3\16\0025\3\18\0005\4\17\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\0035\4\28\0=\4\29\3=\3\30\0025\3\31\0004\4\0\0=\4\19\0034\4\0\0=\4\21\0035\4 \0=\4\23\0035\4!\0=\4\25\0034\4\0\0=\4\27\0034\4\0\0=\4\29\3=\3\"\0024\3\0\0=\3#\0024\3\0\0=\3\n\0024\3\0\0=\3$\0024\3\0\0=\3%\2B\0\2\1K\0\1\0\15extensions\20inactive_winbar\ftabline\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\1\2\0\0\rfilename\14lualine_b\1\4\0\0\vbranch\tdiff\16diagnostics\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\frefresh\1\0\3\ftabline\3Ë\a\vwinbar\3Ë\a\15statusline\3Ë\a\17ignore_focus\23disabled_filetypes\vwinbar\15statusline\1\0\0\23section_separators\1\0\2\tleft\bÓÇ∞\nright\bÓÇ≤\25component_separators\1\0\2\tleft\bÓÇ±\nright\bÓÇ≥\1\0\4\ntheme\tauto\18icons_enabled\2\17globalstatus\1\25always_divide_middle\2\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: base46
time([[Config for base46]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27plugins.configs.base46\frequire\0", "config", "base46")
time([[Config for base46]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-ts-context-commentstring ]]
vim.cmd [[ packadd LuaSnip ]]

-- Config for: LuaSnip
try_loadstring("\27LJ\2\n…\1\0\0\3\0\t\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0006\1\4\0009\1\5\0019\1\6\1B\1\1\0028\0\1\0\15\0\0\0X\1\fÄ6\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\a\0\14\0\0\0X\0\5Ä6\0\0\0'\2\1\0B\0\2\0029\0\b\0B\0\1\1K\0\1\0\19unlink_current\16jump_active\25nvim_get_current_buf\bapi\bvim\18current_nodes\fsession\fluasnip\frequire˘\2\1\0\b\0\20\0(6\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\1Ä2\0 Ä5\2\3\0009\3\4\0019\3\5\3\18\5\2\0B\3\2\0016\3\1\0'\5\6\0B\3\2\0029\3\a\3B\3\1\0016\3\1\0'\5\6\0B\3\2\0029\3\a\0035\5\v\0006\6\b\0009\6\t\0069\6\n\6\14\0\6\0X\a\1Ä'\6\f\0=\6\r\5B\3\2\0016\3\b\0009\3\14\0039\3\15\3'\5\16\0005\6\18\0003\a\17\0=\a\19\6B\3\3\1K\0\1\0K\0\1\0\rcallback\1\0\0\0\16InsertLeave\24nvim_create_autocmd\bapi\npaths\5\1\0\0\21luasnippets_path\6g\bvim\14lazy_load luasnip.loaders.from_vscode\15set_config\vconfig\1\0\2\17updateevents\29TextChanged,TextChangedI\fhistory\2\fluasnip\frequire\npcall\0", "config", "LuaSnip")

vim.cmd [[ packadd cmp_luasnip ]]
vim.cmd [[ packadd mason-lspconfig.nvim ]]

-- Config for: mason-lspconfig.nvim
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugins.configs.lsp\frequire\0", "config", "mason-lspconfig.nvim")

time([[Sequenced loading]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
