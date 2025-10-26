Partner_API.Partner {
  key = "faker",
  unlocked = false,
  discovered = true,
  pos = { x = 2, y = 0 },
  atlas = "partners_atlas",
  config = { extra = { active = true } },
  link_config = { j_paperback_subterfuge = 1 },

  loc_vars = function(self, info_queue, card)
    if next(SMODS.find_card("j_paperback_subterfuge")) then
      return {
        key = "pnr_paperback_faker_buffed"
      }
    end
  end,
  calculate = function(self, card, context)
    if context.destroy_card and context.cardarea == G.play then
      -- Destroy card
      if (card.ability.extra.active or next(SMODS.find_card("j_paperback_subterfuge"))) and #context.full_hand == 1 then
        card.ability.extra.active = false
        return {
          remove = true,
          message = localize('paperback_destroyed_ex'),
          colour = G.C.MULT
        }
      end
    end

    if context.setting_blind then
      card.ability.extra.active = true
    end
  end,

  check_for_unlock = function(self, args)
    if get_deck_win_sticker(G.P_CENTERS.b_znm_firewalk) then return true end
  end,
}
