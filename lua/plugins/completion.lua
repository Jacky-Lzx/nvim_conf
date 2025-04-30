local function findLast(haystack, needle)
  --Set the third arg to false to allow pattern matching
  local found = haystack:reverse():find(needle:reverse(), nil, true)
  if found then
    return haystack:len() - needle:len() - found + 2
  else
    return found
  end
end

return {
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
      "L3MON4D3/LuaSnip",
      "onsails/lspkind-nvim",
      "fang2hou/blink-copilot",
      -- Spell source based on Neovim's `spellsuggest`.
      "ribru17/blink-cmp-spell",
      ---Use treesitter to highlight the label text for the given list of sources.
      "xzbdmw/colorful-menu.nvim",
    },

    event = { "InsertEnter", "CmdlineEnter" },

    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      -- stylua: ignore
      keymap = {
        -- If the command/function returns false or nil, the next command/function will be run.
        preset = "default",
        ["<A-k>"] = { function(cmp) return cmp.select_prev({ auto_insert = false }) end, "fallback", },
        ["<A-j>"] = { function(cmp) return cmp.select_next({ auto_insert = false }) end, "fallback", },
        ["<C-p>"] = { function(cmp) return cmp.select_prev({ auto_insert = false }) end, "fallback", },
        ["<C-n>"] = { function(cmp) return cmp.select_next({ auto_insert = false }) end, "fallback", },

        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        -- ["<A-u>"] = { "scroll_documentation_up", "fallback" },
        -- ["<A-d>"] = { "scroll_documentation_down", "fallback" },

        ["<Tab>"] = { function(cmp) return cmp.accept() end, "fallback", },
        ["<CR>"] = { function(cmp) return cmp.accept() end, "fallback", },
        -- Close current completion and insert a newline
        ["<S-CR>"] = { function(cmp) cmp.hide() return false end, "fallback", },

        -- Show/Remove completion
        ["<A-/>"] = { function(cmp) if cmp.is_menu_visible() then return cmp.hide() else return cmp.show() end end, "fallback", },

        -- show with a list of providers
        ["<C-space>"] = {
          --- Disable copilot suggestions
          function(cmp)
            cmp.show({
              providers = (function()
                local success, node = pcall(vim.treesitter.get_node)
                if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
                then return { "buffer" } else return { "lazydev", "lsp", "path", "snippets" } end
              end)(),
            })
          end,
        },

        ["<A-n>"] = { function(cmp) cmp.show({ providers = {"buffer"} }) end, },
        ["<A-p>"] = { function(cmp) cmp.show({ providers = {"buffer"} }) end, },
      },

      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        -- use_nvim_cmp_as_default = true,
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        -- nerd_font_variant = "mono",
        nerd_font_variant = "normal",
      },

      snippets = {
        preset = "luasnip",
      },

      sources = {
        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        -- "buffer" source is used to complete words
        -- default = { "lazydev", "copilot", "lsp", "path", "snippets", "buffer", "spell" },
        -- default = { "lazydev", "copilot", "lsp", "path", "snippets" },
        default = function()
          local success, node = pcall(vim.treesitter.get_node)
          if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
            return { "buffer" }
          else
            return { "lazydev", "copilot", "lsp", "path", "snippets", "buffer" }
          end
        end,
        per_filetype = {
          codecompanion = { "codecompanion" },
        },

        providers = {
          path = {
            score_offset = 95,
            opts = {
              get_cwd = function(_)
                return vim.fn.getcwd()
              end,
            },
          },
          buffer = {
            score_offset = 20,
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 90,
          },
          lsp = {
            -- Default
            -- Filter text items from the LSP provider, since we have the buffer provider for that
            transform_items = function(_, items)
              return vim.tbl_filter(function(item)
                return item.kind ~= require("blink.cmp.types").CompletionItemKind.Text
              end, items)
            end,
            score_offset = 60,
            fallbacks = { "buffer" },
          },
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
            opts = {
              kind_icon = "",
              kind_hl = "DevIconCopilot",
            },
          },
          spell = {
            name = "Spell",
            module = "blink-cmp-spell",
            score_offset = 10,
            opts = {
              use_cmp_spell_sorting = true,
              -- -- EXAMPLE: Only enable source in `@spell` captures, and disable it
              -- -- in `@nospell` captures.
              -- enable_in_context = function()
              --   local curpos = vim.api.nvim_win_get_cursor(0)
              --   local captures = vim.treesitter.get_captures_at_pos(0, curpos[1] - 1, curpos[2] - 1)
              --   local in_spell_capture = false
              --   for _, cap in ipairs(captures) do
              --     if cap.capture == "spell" then
              --       in_spell_capture = true
              --     elseif cap.capture == "nospell" then
              --       return false
              --     end
              --   end
              --   return in_spell_capture
              -- end,
            },
          },
          -- Hide snippets after trigger character
          -- Trigger characters are defined by the sources. For example, for Lua, the trigger characters are ., ", '.
          snippets = {
            score_offset = 70,
            should_show_items = function(ctx)
              return ctx.trigger.initial_kind ~= "trigger_character"
            end,
            fallbacks = { "buffer" },
          },
          cmdline = {
            min_keyword_length = 2,
            -- Ignores cmdline completions when executing shell commands
            enabled = function()
              return vim.fn.getcmdtype() ~= ":" or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
            end,
          },
        },
      },

      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
          "exact",
          -- defaults
          "score",
          "sort_text",
        },
      },

      completion = {
        -- NOTE: some LSPs may add auto brackets themselves anyway
        accept = { auto_brackets = { enabled = true } },
        list = { selection = { preselect = true, auto_insert = false } },

        menu = {
          border = "rounded",
          max_height = 20,
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
            components = {
              label = {
                text = function(ctx)
                  ---Print copilot suggestions in a different way
                  if ctx.source_name == "copilot" then
                    local last_match_index = ctx.label_matched_indices[#ctx.label_matched_indices]
                    if last_match_index then
                      local label_len = #ctx.label
                      if last_match_index == label_len then
                        return ctx.label
                      end
                      -- Find the last index of the space
                      local last_space_index = findLast(ctx.label:sub(1, last_match_index + 2), " ")
                      if last_space_index then
                        return ctx.label:sub(last_space_index + 1)
                      else
                        return ctx.label
                      end
                    end
                    return ctx.label
                  end
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  if ctx.source_name == "copilot" then
                    return "Comment"
                  end
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local icon = ctx.kind_icon
                  if icon then
                    -- Do nothing
                  elseif vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
                  end

                  return icon .. ctx.icon_gap
                end,

                -- Optionally, use the highlight groups from nvim-web-devicons
                -- You can also add the same function for `kind.highlight` if you want to
                -- keep the highlight groups in sync with the icons.
                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  if hl then
                    -- Do nothing
                  elseif vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
              },
            },
          },
        },
        documentation = {
          auto_show = true,
          -- Delay before showing the documentation window
          auto_show_delay_ms = 200,
          window = {
            min_width = 10,
            max_width = 120,
            max_height = 20,
            border = "rounded",
            winblend = 0,
            winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
            -- Note that the gutter will be disabled when border ~= 'none'
            scrollbar = true,
            -- Which directions to show the documentation window,
            -- for each of the possible menu window directions,
            -- falling back to the next direction when there's not enough space
            direction_priority = {
              menu_north = { "e", "w", "n", "s" },
              menu_south = { "e", "w", "s", "n" },
            },
          },
        },
        -- Displays a preview of the selected item on the current line
        ghost_text = {
          enabled = true,
          -- Show the ghost text when an item has been selected
          show_with_selection = true,
          -- Show the ghost text when no item has been selected, defaulting to the first item
          show_without_selection = false,
          -- Show the ghost text when the menu is open
          show_with_menu = true,
          -- Show the ghost text when the menu is closed
          show_without_menu = true,
        },
      },
      signature = {
        enabled = false,
        window = {
          min_width = 1,
          max_width = 100,
          max_height = 10,
          border = "single", -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
          winblend = 0,
          winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
          scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
          -- Which directions to show the window,
          -- falling back to the next direction when there's not enough space,
          -- or another window is in the way
          direction_priority = { "n" },
          -- Disable if you run into performance issues
          treesitter_highlighting = true,
          show_documentation = true,
        },
      },
      cmdline = {
        completion = {
          menu = {
            auto_show = true,
          },
        },

        keymap = {
          preset = "none",
          -- stylua: ignore
          ["<A-k>"] = { function(cmp) return cmp.select_prev({ auto_insert = false }) end, "fallback", },
          -- stylua: ignore
          ["<A-j>"] = { function(cmp) return cmp.select_next({ auto_insert = false }) end, "fallback", },
          -- stylua: ignore
          ["<C-p>"] = { function(cmp) return cmp.select_prev({ auto_insert = false }) end, "fallback", },
          -- stylua: ignore
          ["<C-n>"] = { function(cmp) return cmp.select_next({ auto_insert = false }) end, "fallback", },
          -- stylua: ignore
          ["<Tab>"] = { function(cmp) return cmp.accept() end, "fallback", },
          -- stylua: ignore
          ["<CR>"] = { function(cmp) if vim.fn.getcmdtype() == ":" then return cmp.accept_and_enter() end return false end, "fallback", },
          -- stylua: ignore
          ["<A-/>"] = { function(cmp) if cmp.is_menu_visible() then return cmp.hide() else return cmp.show() end end, "fallback", },
        },
      },
    },
  },
}
