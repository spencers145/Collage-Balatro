SMODS.Joker {
  key = 'cleanslate',
  name = 'Clean Slate',
  atlas = 'Jokers',
  rarity = 1,
  cost = 6,
  unlocked = true, 
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = GetJokersAtlasTable('cleanslate'),
  config = {
    extra = {
      plus_mult = 15
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.plus_mult }
    } 
  end,
  
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.joker_main then
      return {
        mult_mod =  card.ability.extra.plus_mult,
        message = localize {
          type = 'variable',
          key = 'a_mult',
          vars = { card.ability.extra.plus_mult }
        },
        colour = G.C.MULT,
      }
    end
  end
}

--override function, changes discard behaviour to discard all cards
local old_func_discard = G.FUNCS.discard_cards_from_highlighted
function G.FUNCS.discard_cards_from_highlighted(e, hook)
  if next(SMODS.find_card('j_RainyDays_cleanslate')) then
    local card_limit = G.hand.config.highlighted_limit;
    G.hand.config.highlighted_limit = #G.hand.cards
    G.hand:unhighlight_all()
    for i = 1, #G.hand.cards do
      G.hand.cards[i].ability.forced_selection = true
      G.hand:add_to_highlighted(G.hand.cards[i], true)
    end
    play_sound('cardSlide1')
    local ret = old_func_discard(e, hook)
    G.hand.config.highlighted_limit = card_limit
    return ret
  else
    return old_func_discard(e, hook)
  end
end

--override function that changes button behaviour - now active when no cards selected if you have cleanslate
local old_func_can_discard = G.FUNCS.can_discard
function G.FUNCS.can_discard(e)
  if next(SMODS.find_card('j_RainyDays_cleanslate')) and G.GAME.current_round.discards_left > 0 then
    e.config.colour = G.C.RED
    e.config.button = 'discard_cards_from_highlighted'
  else
    return old_func_can_discard(e)
  end
end