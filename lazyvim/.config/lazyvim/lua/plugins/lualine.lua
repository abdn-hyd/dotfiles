return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
    config = function()
      -- import lualine plugin safely
      local status, lualine = pcall(require, "lualine")
      if not status then
        return
      end

      -- get lualine gruvbox theme
      local lualine_gruvbox = require("lualine.themes.gruvbox")

      -- new colors for theme
      local new_colors = {
        white = "ffffcc",
        green = "#2fdedb",
        violet = "#FF61EF",
        yellow = "#FFDA7B",
        black = "#000000",
      }

      -- change gruvbox theme colors
      lualine_gruvbox.normal.a.bg = new_colors.white
      lualine_gruvbox.insert.a.bg = new_colors.green
      lualine_gruvbox.visual.a.bg = new_colors.violet
      lualine_gruvbox.command = {
        a = {
          gui = "bold",
          bg = new_colors.yellow,
          fg = new_colors.black, -- black
        },
      }

      -- configure lualine with modified theme
      lualine.setup({
        options = {
          theme = lualine_gruvbox,
        },
      })
    end,
  },
}
