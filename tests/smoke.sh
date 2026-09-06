#!/bin/sh
set -eu

root=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)

(
  cd -- "$root"
  export NVIM_CONFIG_ROOT="$root"

  # smoke.lua already includes lsp_config.lua.
  for test in smoke math_conditions commands python rust integrations open_at_cursor tooling lualine_lazy mini_diff_lazy; do
    printf '\nRunning tests/%s.lua\n' "$test"
    nvim --headless -u NONE -i NONE --noplugin -l "$root/tests/$test.lua"
  done

  LUALINE_TEST=before nvim --headless -u NONE -i NONE --noplugin -l "$root/tests/lualine_lazy.lua"
  MINI_DIFF_TEST=direct nvim --headless -u NONE -i NONE --noplugin -l "$root/tests/mini_diff_lazy.lua"

  printf '\nRunning startup smoke test\n'
  NVIM_SMOKE_TEST=1 nvim --headless -i NONE -u "$root/init.lua" -c "lua vim.defer_fn(function() vim.cmd('quitall!') end, 300)"
)
