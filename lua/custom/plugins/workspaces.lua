
return {
	'natecraddock/workspaces.nvim',
  config = function ()
    require('workspaces').setup()
    vim.keymap.set("n", "<leader>ww", vim.cmd.WorkspacesOpen)
  end
}
