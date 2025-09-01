return {
  name = "[C++] Run",
  builder = function()
    local filename_without_ext = vim.fn.expand("%:t:r")
    -- check if the file exist
    local executable_name = filename_without_ext
    if vim.fn.filereadable(executable_name) == 0 then
      executable_name = vim.fn.input("Executable: ")
      if executable_name == "" then
        local log = require("overseer.log")
        log:error("No executable")
        return { cmd = "exit", args = { "1" } }
      end
    end

    local args_str = vim.fn.input("CommandLine Args:", "")
    local args = vim.split(args_str, " ", { plain = true })

    return {
      cmd = { "./" .. executable_name },
      args = args,
    }
  end,
  condition = {
    filetype = { "cpp" },
  },
}
