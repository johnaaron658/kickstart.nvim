return {
  'akinsho/flutter-tools.nvim',
  config = function()
    require("flutter-tools").setup {
      ui = {
	      border = "rounded",
	      notification_style = "native",
      },
      decorations = {
	      statusline = {
		      app_version = false,
		      device = true,
	      },
      },
      widget_guides = {
	      enabled = true,
      },
      closing_tags = {
	      highlight = "ErrorMsg",
	      prefix = "//",
	      enabled = true,
      },
      lsp = {
	      color = {
		      enabled = false,
		      background = false,
		      foreground = false,
		      virtual_text = true,
		      virtual_text_str = "■",
	      },
	      settings = {
		      showTodos = true,
		      completeFunctionCalls = true,
		      enableSnippets = true,
	      },
      },
      debugger = {
	      enabled = true,
	      run_via_dap = false,
      },
      -- dev_log = {
      --   enabled = true,
      --   open_cmd = "tabedit", -- command to use to open the log buffer
      -- },
    }


    vim.keymap.set("n", "<A-e>", function() require("telescope").extensions.flutter.commands() end);
  end
}
