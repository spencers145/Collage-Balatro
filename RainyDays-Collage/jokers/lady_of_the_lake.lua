SMODS.Joker {
  key = 'lady_of_the_lake',
  name = 'Lady of the Lake',
  atlas = 'Jokers',
  rarity = 2,
  cost = 6,
  unlocked = true, 
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = GetJokersAtlasTable('lady_of_the_lake'),

  
  calculate = function (self, card, context)
    if context.before and context.main_eval and not context.blueprint then
      for i = 1, #context.full_hand do
        if next(SMODS.get_enhancements(context.full_hand[i])) then
          return
        end
      end
      
      local card = pseudorandom_element(context.scoring_hand, pseudoseed('ladylake' .. G.GAME.round_resets.ante))
      if card then
        local cen_pool = {}
        for _, enhancement_center in pairs(G.P_CENTER_POOLS["Enhanced"]) do
          cen_pool[#cen_pool + 1] = enhancement_center
        end
        local enhancement = pseudorandom_element(cen_pool, 'ladylake')
        card:set_ability(enhancement, nil, true)
        G.E_MANAGER:add_event(Event({
          func = function()
            card:juice_up()
            return true
          end
        }))
        return {
          message = localize('rainydays_enhanced')
        }
      end
    end
  end
}