-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- copy current file path
vim.api.nvim_create_user_command("Cppath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- clean all .ds_store files
vim.api.nvim_create_user_command("CleanDSStoreFiles", function()
  -- Find all .DS_Store files recursively
  local current_dir = vim.fn.getcwd()
  local ds_store_files = vim.fn.systemlist("find " .. current_dir .. " -name .DS_Store")
  for _, file in ipairs(ds_store_files) do
    vim.fn.delete(file) -- Delete each .DS_Store file
  end
  vim.notify("Cleaned all .DS_Store files in the current directory.")
end, {})

-- define highlighting rule and color
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "lua", "c", "cpp", "javascript", "go", "rust" },
  callback = function()
    vim.opt_local.conceallevel = 2

    vim.cmd([[
      syntax region MyHighlightRegion
      \ matchgroup=Conceal
      \ start='@@'
      \ end='@@'
      \ concealends
    ]])
  end,
})
