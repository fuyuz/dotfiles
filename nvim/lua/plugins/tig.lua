require('toggleterm').setup {
  size = 30,
  direction = 'horizontal',
}

local Terminal = require("toggleterm.terminal").Terminal
local tig = Terminal:new({
	cmd = "tig",
	direction = "float",
  hidden = true,
})

vim.keymap.set('n', '<leader>g', function() tig:toggle() end, {})
