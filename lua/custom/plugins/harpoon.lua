return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, { desc = 'Add current file to Harpoon list' })
      vim.keymap.set('n', '<leader>hm', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Toggle Harpoon Menu' })

      vim.keymap.set('n', '<C-a>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<C-s>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<C-q>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<C-e>', function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<C-h>', function()
        harpoon:list():prev()
      end)
      vim.keymap.set('n', '<C-l>', function()
        harpoon:list():next()
      end)
    end,
  },
  {
    'letieu/harpoon-lualine',
    dependencies = {
      {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
      },
    },
  },
  -- {
  -- 	"cbochs/grapple.nvim",
  -- 	dependencies = {
  -- 		{ "nvim-tree/nvim-web-devicons", lazy = true },
  -- 	},
  -- 	opts = {
  -- 		scope = "git", -- also try out "git_branch"
  -- 	},
  -- 	event = { "BufReadPost", "BufNewFile" },
  -- 	cmd = "Grapple",
  -- 	keys = {
  -- 		{ "<leader>hm", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
  -- 		{ "<leader>ht", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple toggle tags" },
  -- 		{ "<leader>hs", "<cmd>Grapple toggle_scopes<cr>", desc = "Grapple toggle scopes" },
  -- 		{ "<C-l>", "<cmd>Grapple cycle forward<cr>", desc = "Grapple cycle forward" },
  -- 		{ "<C-h>", "<cmd>Grapple cycle backward<cr>", desc = "Grapple cycle backward" },
  -- 		{ "<C-1>", "<cmd>Grapple select index=1<cr>", desc = "Grapple select 1" },
  -- 		{ "<C-2>", "<cmd>Grapple select index=2<cr>", desc = "Grapple select 2" },
  -- 		{ "<C-3>", "<cmd>Grapple select index=3<cr>", desc = "Grapple select 3" },
  -- 		{ "<C-4>", "<cmd>Grapple select index=4<cr>", desc = "Grapple select 4" },
  -- 		{ "<C-5>", "<cmd>Grapple select index=4<cr>", desc = "Grapple select 5" },
  -- 	},
  -- },
}
