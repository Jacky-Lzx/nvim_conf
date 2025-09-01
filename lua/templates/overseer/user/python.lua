return {
  name = "[Python] Run current file",
  builder = function()
    local file = vim.fn.expand("%:p")

    -- Get command line arguments from input
    local args_str = vim.fn.input("CommandLine Args:", "")
    local args = { file }
    for arg in string.gmatch(args_str, "[^%s]+") do
      table.insert(args, arg)
    end

    return {
      cmd = { "python" },
      args = args,
    }
  end,
  condition = {
    filetype = { "python" },
  },
}
