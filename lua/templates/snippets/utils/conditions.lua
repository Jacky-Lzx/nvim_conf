local M = {}

M.line_begin = function(line_to_cursor)
  local notify = require("snacks.notify")
  notify.info(line_to_cursor)
  return line_to_cursor:match("^%s*$")
end

return M
