return {
  -- First plugin: telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Second plugin: telescope-fzf-native.nvim
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    after = "nvim-telescope/telescope.nvim", -- Ensure telescope.nvim is loaded first
    config = function()
      -- You dont need to set any of these options. These are the default ones. Only
      -- the loading is important
      local actions_setup, actions = pcall(require, "telescope.actions")
      if not actions_setup then
        return
      end

      require("telescope").setup({
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
        -- configure custom mappings
        defaults = {
          preview = {
            treesitter = false,
          },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
            },
          },
        },
      })
      -- To get fzf loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require("telescope").load_extension("fzf")
    end,
  },
}
