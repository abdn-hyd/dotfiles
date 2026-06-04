-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options before

local opt = vim.opt -- for conciseness

-- tabs & indentation
opt.autoindent = true -- copy indent from current line when starting new one

-- appearence
opt.background = "dark" -- colorschemes that can be light or dark will be made dark

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

opt.iskeyword:append("-") -- consider string-string as whole keyword

opt.undodir = "~/.local/state/lazyVim/undo/"
opt.undolevels = 100 -- maximum number of changes that can be undo
