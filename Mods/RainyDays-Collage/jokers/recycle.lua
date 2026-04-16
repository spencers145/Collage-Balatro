SMODS.Joker {
  key = 'recycle',
  atlas = 'Jokers',
  rarity = 2,
  cost = 6,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('recycle'),
  config = {
    extra = {
      bonus_mult = 2
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.bonus_mult }
    } 
  end,
  
  calculate = function(self, card, context)
    if context.discard and context.other_card:get_id() >= 2 and context.other_card:get_id() <= 5 then
      context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.bonus_mult
      return {
        card = context.other_card,
        message = localize('k_upgrade_ex'),
        colour = G.C.MULT
      }
    end
    
    if context.stay_flipped and context.from_area == G.hand and context.to_area == G.discard and not context.blueprint then
      if context.other_card:get_id() >= 2 and context.other_card:get_id() <= 5 then
        G.GAME.rd_shuffle_deck = true
        G.E_MANAGER:add_event(Event({
          func = function()
            if G.GAME.rd_shuffle_deck then
              G.deck:shuffle('recycle'..G.GAME.round_resets.ante)
              G.GAME.rd_shuffle_deck = nil
            end
            return true
          end
        }))
    
        return {
          modify = { to_area = G.deck }
        }
      end
    end
  end
}