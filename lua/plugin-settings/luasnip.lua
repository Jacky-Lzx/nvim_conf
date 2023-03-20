-- require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/Desktop/test" } })
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/Users/lizexi/Library/Application Support/Code/User/snippets" } })

vim.cmd([[
  " press <Tab> to expand or jump in a snippet. These can also be mapped separately
  " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
  imap <silent><expr> <C-n> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
  " -1 for jumping backwards.
  inoremap <silent> <C-p> <cmd>lua require'luasnip'.jump(-1)<Cr>

  snoremap <silent> <C-n> <cmd>lua require('luasnip').jump(1)<Cr>
  snoremap <silent> <C-p> <cmd>lua require('luasnip').jump(-1)<Cr>

  " For changing choices in choiceNodes (not strictly necessary for a basic setup).
  imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
  smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]])
