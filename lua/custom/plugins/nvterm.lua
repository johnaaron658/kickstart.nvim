
return {
  'NvChad/nvterm',
  config = function ()
    require("nvterm").setup()
    vim.keymap.set("n", "<A-u>", function() require("nvterm.terminal").toggle("vertical") end);
    vim.keymap.set("t", "<A-u>", function() require("nvterm.terminal").toggle("vertical") end);
  end
}
