require("telescope").load_extension "file_browser"

require("telescope").setup{
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
    },
  },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>p', builtin.find_files, {})
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require("telescope").load_extension('harpoon')

local harpoon = require("harpoon")
harpoon:setup()

-- harpoon
vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, {})
vim.keymap.set('n', '<leader>h', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {})

-- coc
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Attach key mappings for LSP functionalities",
  callback = function()
    vim.keymap.set('n', 'gd', '<Plug>(coc-definition)')
    vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)')
    vim.keymap.set('n', 'gr', '<Plug>(coc-implementation)')
    vim.keymap.set('n', 'gi', '<Plug>(coc-references)')
    vim.keymap.set('n', '<leader>rn', '<Plug>(coc-rename)')
    vim.keymap.set('n', '<leader>qf', '<Plug>(coc-fix-current)')
    function _G.show_docs()
      local cw = vim.fn.expand('<cword>')
      if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
      elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
      else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
      end
    end
    vim.keymap.set('n', '<leader>K', '<CMD>lua _G.show_docs()<CR>', { silent = true })
  end
})
