return {
  "nvim-mini/mini.hipatterns",
  event = "VeryLazy",
  config = function()
    local hipatterns = require("mini.hipatterns")
    hipatterns.setup({
      highlighters = {
        user_note = {
          pattern = "@@.-@@",
          group = "MiniHipatternsNote",
        },

        important = {
          pattern = "IMPORTANT",
          group = "ErrorMsg",
        },

        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })
  end,
}
