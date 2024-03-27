return {
  -- amongst your other plugins
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        start_in_insert = true,
        direction = 'float',
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.3
          end
        end,
      }
      -- local Terminal = require('toggleterm.terminal').Terminal
      -- local lazygit = Terminal:new {
      --   cmd = 'lazygit',
      --   hidden = false,
      --   autochdir = true,
      --   direction = 'float',
      --   count = 7,
      -- }
      -- local ollama = Terminal:new {
      --   cmd = 'ollama run mistral',
      --   hidden = true,
      --   direction = 'float',
      --   count = 8,
      -- }

      -- function _lazygit_toggle()
      --   lazygit:toggle()
      -- end
      --
      -- function _ollama_toggle()
      --   ollama:toggle()
      -- end

      vim.keymap.set('n', '<C-CR>', '<cmd>exe v:count1 . "ToggleTerm"<CR>i', { noremap = true, silent = true, desc = 'Toggle Floating Terminal' })
      vim.keymap.set('t', '<C-CR>', '<C-\\><C-n><cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true, desc = 'Toggle Floating Terminal' })

      vim.keymap.set(
        'n',
        '<leader>tv',
        '<cmd>exe v:count1 . "ToggleTerm direction=vertical"<CR>',
        { noremap = true, silent = true, desc = 'Toggle Vertical Terminal' }
      )
      vim.keymap.set(
        'n',
        '<leader>th',
        '<cmd>exe v:count1 . "ToggleTerm direction=horizontal"<CR>',
        { noremap = true, silent = true, desc = 'Toggle Horizontal Terminal' }
      )

      -- vim.api.nvim_set_keymap('n', '<leader>gs', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })
      -- vim.keymap.set('n', '<leader>Gp', '<cmd>lua _ollama_toggle()<CR>', { noremap = true, silent = true })
    end,
  },
}
