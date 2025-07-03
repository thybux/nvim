return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        style_preset = require("bufferline").style_preset.default,
        themable = true,
        numbers = "none", -- "none" | "ordinal" | "buffer_id" | "both"
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        
        -- Indicateurs
        indicator = {
          icon = '▎',
          style = 'icon', -- 'icon' | 'underline' | 'none'
        },
        
        -- Boutons
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        
        -- Longueur des noms
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        
        -- Diagnostics LSP
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " " or (e == "warning" and " " or "")
            s = s .. n .. sym
          end
          return s
        end,
        
        -- Filtres
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          }
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,
        move_wraps_at_ends = false,
        separator_style = "thin", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = {'close'}
        },
        sort_by = 'insert_after_current',
        
        -- Groupes personnalisés
        groups = {
          options = {
            toggle_hidden_on_enter = true
          },
          items = {
            {
              name = "Tests",
              highlight = {underline = true, sp = "blue"},
              priority = 2,
              icon = "",
              matcher = function(buf)
                return buf.name:match('%_test') or buf.name:match('%.test')
              end,
            },
            {
              name = "Docs",
              highlight = {underline = true, sp = "green"},
              auto_close = false,
              matcher = function(buf)
                return buf.name:match('%.md') or buf.name:match('%.txt')
              end,
            }
          }
        },
      },
      
      highlights = {
        fill = {
          bg = '#1e1e2e',
        },
        background = {
          fg = '#7f849c',
          bg = '#1e1e2e',
        },
        buffer_selected = {
          fg = '#cdd6f4',
          bg = '#313244',
          bold = true,
          italic = false,
        },
        buffer_visible = {
          fg = '#7f849c',
          bg = '#1e1e2e',
        },
        close_button = {
          fg = '#7f849c',
          bg = '#1e1e2e',
        },
        close_button_visible = {
          fg = '#7f849c',
          bg = '#1e1e2e',
        },
        close_button_selected = {
          fg = '#f38ba8',
          bg = '#313244',
        },
        tab_selected = {
          fg = '#cdd6f4',
          bg = '#313244',
        },
        tab_separator = {
          fg = '#1e1e2e',
          bg = '#1e1e2e',
        },
        tab_separator_selected = {
          fg = '#313244',
          bg = '#313244',
        },
        indicator_selected = {
          fg = '#89b4fa',
          bg = '#313244',
        },
        modified = {
          fg = '#f9e2af',
          bg = '#1e1e2e',
        },
        modified_visible = {
          fg = '#f9e2af',
          bg = '#1e1e2e',
        },
        modified_selected = {
          fg = '#f9e2af',
          bg = '#313244',
        },
        duplicate_selected = {
          fg = '#89b4fa',
          bg = '#313244',
          italic = true,
        },
        duplicate_visible = {
          fg = '#7f849c',
          bg = '#1e1e2e',
          italic = true,
        },
        duplicate = {
          fg = '#7f849c',
          bg = '#1e1e2e',
          italic = true,
        },
        separator_selected = {
          fg = '#313244',
          bg = '#313244',
        },
        separator_visible = {
          fg = '#1e1e2e',
          bg = '#1e1e2e',
        },
        separator = {
          fg = '#1e1e2e',
          bg = '#1e1e2e',
        },
      },
    })
  end,
}
