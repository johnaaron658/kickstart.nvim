
return {
	'natecraddock/workspaces.nvim',
  config = function ()
    require('workspaces').setup()
    vim.keymap.set("n", "<leader>ww", vim.cmd.WorkspacesOpen)
    vim.keymap.set("n", "<leader>wa", vim.cmd.WorkspacesAdd)
  end
}
