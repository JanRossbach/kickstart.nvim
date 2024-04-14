return {
  -- amongst your other plugins
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        start_in_insert = true,
        direction = 'float',
        open_mapping = [[<c-cr>]],
        autochdir = true,
        close_on_exit = true,
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.3
          end
        end,
      }

      -- vim.keymap.set('n', '<leader>gl', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })
      -- vim.keymap.set('n', '<C-CR>', '<cmd>exe v:count1 . "ToggleTerm"<CR>i', { noremap = true, silent = true, desc = 'Toggle Floating Terminal' })
      -- vim.keymap.set('t', '<C-CR>', '<C-\\><C-n><cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true, desc = 'Toggle Floating Terminal' })
      --
      vim.keymap.set(
        'n',
        '<c-t><c-v>',
        '<cmd>exe v:count1 "ToggleTerm direction=vertical"<CR>',
        { noremap = true, silent = true, desc = 'Toggle Vertical Terminal' }
      )
      vim.keymap.set(
        'n',
        '<c-t><c-h>',
        '<cmd>exe v:count1 "ToggleTerm direction=horizontal"<CR>',
        { noremap = true, silent = true, desc = 'Toggle Horizontal Terminal' }
      )
      vim.keymap.set(
        'n',
        '<c-t><c-f>',
        '<cmd>exe v:count1 . "ToggleTerm direction=float"<CR>',
        { noremap = true, silent = true, desc = 'Toggle Horizontal Terminal' }
      )

      -- vim.api.nvim_set_keymap('n', '<leader>gs', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })
      -- vim.keymap.set('n', '<leader>Gp', '<cmd>lua _ollama_toggle()<CR>', { noremap = true, silent = true })
    end,
  },
}
