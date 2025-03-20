
return {
  'ThePrimeagen/harpoon',
  config = function ()
    local ui = require("harpoon.ui")
    local harpoon = require("harpoon")
    local utils = require("harpoon.utils")
    local log = require("harpoon.dev").loglocal log = require("harpoon.dev").log
    local M = require("harpoon.mark")

    local callbacks = {}

    local function get_buf_name(id)
      log.trace("_get_buf_name():", id)
      if id == nil then
        return utils.normalize_path(vim.api.nvim_buf_get_name(0))
      elseif type(id) == "string" then
        return utils.normalize_path(id)
      end

      local idx = M.get_index_of(id)
      if M.valid_index(idx) then
        return M.get_marked_file_name(idx)
      end
      --
      -- not sure what to do here...
      --
      return ""
    end

    -- I am trying to avoid over engineering the whole thing.  We will likely only
    -- need one event emitted
    local function emit_changed()
      log.trace("_emit_changed()")

      local global_settings = harpoon.get_global_settings()

      if global_settings.save_on_change then
        harpoon.save()
      end

      if global_settings.tabline then
        vim.cmd("redrawt")
      end

      if not callbacks["changed"] then
        log.trace("_emit_changed(): no callbacks for 'changed', returning")
        return
      end

      for idx, cb in pairs(callbacks["changed"]) do
        log.trace(
          string.format(
            "_emit_changed(): Running callback #%d for 'changed'",
            idx
          )
        )
        cb()
      end
    end

    local function create_mark(filename)
      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      log.trace(
        string.format(
          "_create_mark(): Creating mark at row: %d, col: %d for %s",
          cursor_pos[1],
          cursor_pos[2],
          filename
        )
      )
      return {
        filename = filename,
        row = cursor_pos[1],
        col = cursor_pos[2],
      }
    end

    local function add_file_to_index(file_name_or_buf_id, idx)
      local buf_name = get_buf_name(file_name_or_buf_id)
      log.trace("add_file():", buf_name)

      log.trace("_validate_buf_name():", buf_name)
      if buf_name == "" or buf_name == nil then
        log.error(
          "_validate_buf_name(): Not a valid name for a mark,",
          buf_name
        )
        error("Couldn't find a valid file name to mark, sorry.")
        return
      end

      local found_idx = idx
      harpoon.get_mark_config().marks[found_idx] = create_mark(buf_name)
      M.remove_empty_tail(false)
      emit_changed()
    end

    vim.keymap.set("n", "<leader>a", M.add_file)
    vim.keymap.set("n", "<A-s>", ui.toggle_quick_menu)
    vim.keymap.set("n", "<A-1>", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<A-2>", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<A-3>", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<A-4>", function() ui.nav_file(4) end)
    vim.keymap.set("n", "<C-1>", function(file) add_file_to_index(file, 1) end)
    vim.keymap.set("n", "<C-2>", function(file) add_file_to_index(file, 2) end)
    vim.keymap.set("n", "<C-3>", function(file) add_file_to_index(file, 3) end)
    vim.keymap.set("n", "<C-4>", function(file) add_file_to_index(file, 4) end)
  end
}
