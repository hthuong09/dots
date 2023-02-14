local opt = vim.opt
local g = vim.g

-- Indentation settings
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Number of spaces to use for each indentation level
opt.smartindent = true -- Automatically indent and unindent code
opt.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
opt.softtabstop = 2 -- Number of spaces to use for a <Tab> keypress in insert mode
opt.autoindent = true -- Copy the indentation of the previous line when starting a new line

-- Display settings
opt.number = true -- Display line numbers
opt.relativenumber = true -- Display relative line numbers
opt.numberwidth = 2 -- Width of the line number column
opt.cursorline = true -- Highlight the current line
opt.list = true -- Display invisible characters
opt.listchars = "tab:» ,extends:›,precedes:‹,nbsp:␣,trail:·,eol:¬" -- Characters used to show invisible characters
opt.fillchars = { eob = " " } -- Replace '~' at the end of buffer with a space

-- Search settings
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- Ignore case when searching, unless an uppercase letter is used

-- Mouse settings
opt.mouse = "a" -- Enable the mouse in all modes

-- Split settings
opt.splitbelow = true -- Open new windows below the current one
opt.splitright = true -- Open new windows to the right of the current one

-- GUI settings
opt.title = true -- Show the filename in the title bar
opt.termguicolors = true -- Use true colors in the terminal
opt.laststatus = 3 -- displays the status line on the last window of the screen when set to 2 or higher
opt.showmode = false -- whether to display the current mode (normal, insert, visual, etc.) in the statusline


-- Clipboard settings
opt.clipboard = "unnamedplus" -- Use the system clipboard

-- Timings
opt.updatetime = 250 -- Faster completion
opt.timeoutlen = 400 -- Time to wait for a mapped sequence to complete

-- Undo settings
opt.undofile = true -- Save undo history

-- Message settings
opt.shortmess:append "sI" -- Reduce the amount of messages shown

-- Sign column
opt.signcolumn = "yes" -- Always show the sign column

-- Which wrap settings
opt.whichwrap:append "<>[]hl" -- Allow < > [ ] { } h l to navigate wrapped lines
opt.textwidth = 0 -- Disable text wrap

-- Popup menu height
opt.pumheight = 10 -- Height of the popup menu

-- Disable backup, write backup, and swap files
opt.backup = false -- Do not make a backup before overwriting a file
opt.writebackup = false -- Do not make a backup when writing a file
opt.swapfile = false -- Do not use swap files for recovery

-- default some provider for better startup time
local default_providers = {
  "node",
  "perl",
  "python3",
  "ruby",
}

for _, provider in ipairs(default_providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
