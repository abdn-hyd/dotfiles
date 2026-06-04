return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- 1. open or close all terminal windows
        open_mapping = [[<C-\>]],

        -- 2. appearence setting
        direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
        shade_terminals = true,
        float_opts = {
          border = "curved", -- 'single', 'double', 'shadow', 'curved'
          winblend = 0, -- transparency (0-100)
        },

        -- 3. size seeting only when direction != 'float'
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,

        start_in_insert = true, -- insert mode
        persist_size = true,
        close_on_exit = true,
        shell = vim.o.shell,
      })

      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        float_opts = {
          border = "curved",
        },
      })

      function _lazygit_toggle()
        lazygit:toggle()
      end

      -- mapping
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        -- <Esc>, between insert and normal mode
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
      end

      -- lazy: use this setting when ToggleTerm is enable
      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
  },
}
