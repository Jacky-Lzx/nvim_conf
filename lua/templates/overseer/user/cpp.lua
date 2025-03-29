return {
  name = "CPP build",
  builder = function()
    -- local file = vim.fn.expand("%:p")
    -- local filename_without_ext = vim.fn.expand("%:t:r")
    return {
      cmd = { "g++" },
      args = {
        'vim.fn.expand("%:p")',
      },
    }
  end,
  condition = {
    filetype = { "cpp" },
  },
}
