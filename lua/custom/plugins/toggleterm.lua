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
    end,
  },
}
