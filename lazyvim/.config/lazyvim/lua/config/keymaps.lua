local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { noremap = true, silent = true, desc = "clear search highlights" })

-- Delete single character without copying into register
keymap.set("n", "x", '"_x', { noremap = true, silent = true, desc = "delete single character" })

-- Increment/decrement numbers
keymap.set("n", "<leader>=", "<C-a>", { noremap = true, silent = true, desc = "increment" }) -- increment
keymap.set("n", "<leader>0", "<C-x>", { noremap = true, silent = true, desc = "decrement" }) -- decrement

-- File path
keymap.set("n", "<leader>fp", ":echo expand('%:p')<CR>")
keymap.set("n", "<leader>cp", ":Cppath<CR>", { noremap = true, desc = "copy current file path" })

-- Delete .DS_Store file
keymap.set("n", "<leader>ds", ":CleanDSStoreFiles<CR>", { noremap = true, desc = "clear all ds_store_files" })

-- Vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", { noremap = true, silent = true, desc = "window maximization" }) -- toggle split window maximization

-- Snacks picker
keymap.set(
  "n",
  "<leader>fs",
  function()
    Snacks.picker.grep({ hidden = true })
  end,
  { noremap = true, silent = true, desc = "find string in current_dir" }
) -- find string in current working directory as you type
keymap.set(
  { "n", "x" },
  "<leader>fw",
  function()
    Snacks.picker.grep_word({ hidden = true })
  end,
  { noremap = true, silent = true, desc = "find string under cursor" }
) -- find string under cursor in current working directory

-- lazygit
vim.keymap.set(
  "n",
  "<leader>lg",
  "<cmd>lua _lazygit_toggle()<CR>",
  { noremap = true, silent = true, desc = "Toggle Lazygit" }
)

-- open current file
keymap.set("n", "<leader>op", "<cmd>!open '%'<CR>", { noremap = true, silent = true, desc = "open file" })

vim.keymap.set("v", '<leader>"', 'c""<Esc>P', { desc = "Surround selection with double quotes" })
vim.keymap.set("v", "<leader>'", "c''<Esc>P", { desc = "Surround selection with single quotes" })
