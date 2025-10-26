SMODS.Joker {
  key = 'sediment',
  name = 'Sediment',
  atlas = 'Jokers',
  rarity = 2,
  cost = 7,
  unlocked = true, 
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = GetJokersAtlasTable('sediment'),
  config = {
    extra = {
      plus_xmult = 3,
      card_amount = 3
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = { 
        card.ability.extra.plus_xmult,
        card.ability.extra.card_amount
      }
    } 
  end,
    
  calculate = function(self, card, context)
    if context.setting_blind then
      local new_cards = {}
      for i = 1, card.ability.extra.card_amount do
        new_cards[i] = SMODS.create_card { set = "Base", area = G.discard }
        table.insert(G.playing_cards, new_cards[i])
        SMODS.debuff_card(new_cards[i], true, card.config.center.key)
      end
      
      G.E_MANAGER:add_event(Event({
        func = function()
          for i = 1, #new_cards do
            new_cards[i]:start_materialize()
            G.play:emplace(new_cards[i])
          end
          return true
        end
      }))
      return {
        message = '+' .. #new_cards .. ' ' .. localize('rainydays_cards'),
        colour = G.C.FILTER,
        func = function()
          for i = 1, #new_cards do
            draw_card(G.play, G.deck, 90, 'up', nil, new_cards[i])
          end
          SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
        end
      }
    end
    
    if context.cardarea == G.jokers and context.joker_main then
      return {
        Xmult_mod = card.ability.extra.plus_xmult,
        message = localize {
          type = 'variable',
          key = 'a_xmult',
          vars = { card.ability.extra.plus_xmult }
        },
        colour = G.C.RED
      }
    end
  end
}