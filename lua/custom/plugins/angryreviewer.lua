return {
  'anufrievroman/vim-angry-reviewer',
  lazy = false,
  config = function()
    vim.g.AngryReviewerEnglish = 'american'
    vim.keymap.set('n', '<leader>rv', '<cmd>AngryReviewer<cr>', { desc = '[R]eview [V]iew' })
  end,
}
