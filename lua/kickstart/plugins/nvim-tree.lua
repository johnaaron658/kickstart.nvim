return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      }
    })

    vim.keymap.set("n", "<C-n>", "<ESC><cmd>NvimTreeFindFileToggle!<CR>")
  end
}
