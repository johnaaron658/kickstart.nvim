
return {
  'NvChad/nvterm',
  config = function ()
    require("nvterm").setup()
    vim.keymap.set("n", "<A-o>", function() require("nvterm.terminal").toggle("vertical") end);
    vim.keymap.set("t", "<A-o>", function() require("nvterm.terminal").toggle("vertical") end);
    vim.keymap.set("n", "<A-u>", function() require("nvterm.terminal").toggle("horizontal") end);
    vim.keymap.set("t", "<A-u>", function() require("nvterm.terminal").toggle("horizontal") end);
    vim.keymap.set("n", "<A-i>", function() require("nvterm.terminal").toggle("float") end);
    vim.keymap.set("t", "<A-i>", function() require("nvterm.terminal").toggle("float") end);
  end
}
