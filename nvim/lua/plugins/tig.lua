require('toggleterm').setup {
  size = 30,
  direction = 'horizontal',
}

local Terminal = require("toggleterm.terminal").Terminal
local tig = Terminal:new({
  cmd = "tig",
  direction = "float",
  hidden = true,
  float_opts = {
    winblend = 0,
    width = function()
      return math.ceil(vim.o.columns * 0.94)
    end,
    height = function()
      return math.ceil(vim.o.lines * 0.8)
    end,
    highlights = {
      border = "FloatBorder",
      background = "NormalFloat",
    },
  },
})

vim.keymap.set('n', '<leader>g', function() tig:toggle() end, {})
