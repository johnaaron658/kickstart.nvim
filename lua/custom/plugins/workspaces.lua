
return {
	'natecraddock/workspaces.nvim',
  config = function ()
    require('workspaces').setup()
    vim.keymap.set('n', '<A-w>', vim.cmd.WorkspacesOpen)
    vim.keymap.set('n', '<A-a>', vim.cmd.WorkspacesAdd)
  end
}
