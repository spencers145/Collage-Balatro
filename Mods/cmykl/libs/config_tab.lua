-- Adds logo to the mod's collection
SMODS.current_mod.description_loc_vars = function(self)
    return {
        text_colour = G.C.WHITE,
        background_colour = HEX("00000000"),
        scale = 1.1
    }
end

SMODS.Atlas {
    key = "cmykl_credits",
    px = 139,
    py = 53,
    path = "cmykl.png"
}

SMODS.Joker {
    key = "config_credits",
    atlas = "cmykl_credits",
    pos = {x = 0, y = 0},
    unlocked = true,
    discovered = true,
    no_collection = true,
    loc_txt = {
        name = "",
        text = {
            ""
        }
    },
    in_pool = function(self, args)
        return false
    end
}

SMODS.current_mod.custom_ui = function(mod_nodes)
    G.cmykl_logo_cardarea = CardArea(G.ROOM.T.x / 2, G.ROOM.T.y / 2, G.CARD_W, G.CARD_H, {type = "title", card_limit = 1})
    local logo_card = Card(G.cmykl_logo_cardarea.T.x, G.cmykl_logo_cardarea.T.x, G.CARD_W * 1.39 * 2.2, G.CARD_H * 0.4 * 2.2, G.P_CENTERS.j_cmykl_config_credits, G.P_CENTERS.j_cmykl_config_credits)
    logo_card.no_ui = true
    G.cmykl_logo_cardarea:emplace(logo_card)
    table.insert(mod_nodes, 2, {
        n = G.UIT.R,
        config = {align = "cm"},
        nodes = {
            {
                n = G.UIT.C,
                config = {align = "cm"},
                nodes = {
                    {
                        n = G.UIT.O,
                        config = {
                            object = G.cmykl_logo_cardarea
                        }
                    }
                }
            }
        }
    })
end


--- Config tab UI ---

SMODS.current_mod.config_tab = function()
  return {
    n = G.UIT.ROOT,
    config = { align = 'cm', padding = 0.05, emboss = 0.05, r = 0.1, colour = G.C.BLACK },
    nodes = {
      { n = G.UIT.R, config = {align = 'cm', padding = 0.05, emboss = 0.05, r = 0.1, colour = HEX('465255')}, nodes = {
        {
          n = G.UIT.R,
          config = { align = 'cm', minh = 1 },
          nodes = {
            { n = G.UIT.T, config = { text = localize('cmykl_requires_restart'), colour = G.C.PURPLE, scale = 0.5 } }
          }
        },
        {n = G.UIT.R, config = {align = 'cm', padding = 0.05, emboss = 0.05, r = 0.1, colour = HEX('4a6972'), minw = 8.5}, nodes = {
          {
            n = G.UIT.R,
            nodes = {
            }
          },
          {
            n = G.UIT.R,
            nodes = {
              {
                n = G.UIT.C,
                config = {tooltip = {text = localize('cmykl_enable_ui_info')}},
                nodes = {
                  create_toggle {
                    label = localize('cmykl_enable_ui'),
                    ref_table = cmykl.config,
                    ref_value = "cmykl_awesome_ui"
                  },
                },
              },
              {
                n = G.UIT.C,
                config = {tooltip = {text = localize('cmykl_enable_quips_info')}},
                nodes = {
                  create_toggle {
                    label = localize('cmykl_enable_quips'),
                    ref_table = cmykl.config,
                    ref_value = 'cmykl_meany_quips'
                  },
                },
              }
            },
          },
      }},
      }},
    }
  }  
end
