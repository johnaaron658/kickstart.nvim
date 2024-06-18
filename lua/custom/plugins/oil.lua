return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function ()
    require("oil").setup({
      lsp_file_methods = {
        -- Time to wait for LSP file operations to complete before skipping
        timeout_ms = 100000,
        -- Set to true to autosave buffers that are updated with LSP willRenameFiles
        -- Set to "unmodified" to only save unmodified buffers
        autosave_changes = true,
      }
    })
    vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
  end
}
