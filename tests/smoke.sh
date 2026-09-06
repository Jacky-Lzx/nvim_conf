#!/bin/sh
set -eu

root=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)

(
  cd -- "$root"
  export NVIM_CONFIG_ROOT="$root"

  # smoke.lua already includes lsp_config.lua.
  for test in smoke math_conditions commands python rust integrations open_at_cursor tooling; do
    printf '\nRunning tests/%s.lua\n' "$test"
    nvim --headless -u NONE -i NONE --noplugin -l "$root/tests/$test.lua"
  done

  printf '\nRunning startup smoke test\n'
  NVIM_SMOKE_TEST=1 nvim --headless -i NONE -u "$root/init.lua" -c "lua vim.defer_fn(function() vim.cmd('quitall!') end, 300)"
)
