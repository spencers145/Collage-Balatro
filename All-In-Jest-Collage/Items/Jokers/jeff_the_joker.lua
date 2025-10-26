local jeff_the_joker = {
  object_type = "Joker",
  order = 89,

  key = "jeff_the_joker",
  config = {
      extra = {
          x_mult = 1,
          x_mult_per_destroy = 0.5,
      }
  },
  rarity = 3,
  pos = { x = 9, y = 3 },
  atlas = 'joker_atlas',
  cost = 6,
  unlocked = true,
  discovered = false,
  blueprint_compat = true, 
  eternal_compat = true, 
  perishable_compat = false,

  loc_vars = function(self, info_queue, card)
      -- Display the current multiplier stored in the card's ability table
      local current_xmult = card.ability.extra.x_mult or 1
      return { vars = { current_xmult, card.ability.extra.x_mult_per_destroy } }
  end,

  calculate = function(self, card, context)
      -- Effect Trigger: Selecting the Small Blind
      if not context.blueprint and context.setting_blind and context.blind.name == "Small Blind" then
          local destroyed_count = 0

          local jokers_to_check = {}
          if G.jokers and G.jokers.cards then
              for _, jkr in ipairs(G.jokers.cards) do
                  table.insert(jokers_to_check, jkr)
              end
          end

          for _, v in ipairs(jokers_to_check) do
              if v ~= card and not v.ability.eternal and v.config.center_key ~= "j_aij_jeff_the_joker" then
                  destroyed_count = destroyed_count + 1
                  v:start_dissolve() 
                  G.E_MANAGER:add_event(Event({
                      trigger = 'after', delay = 0.7,
                      func = function()
                          if v and not v.removed then destroyed_count = destroyed_count - 1 end
                          return true
                      end
                  }))
              end
          end

          if destroyed_count > 0 then
              SMODS.scale_card(card, {
	            ref_table = card.ability.extra,
                ref_value = "x_mult",
	            scalar_value = "x_mult_per_destroy",
                operation = function(ref_table, ref_value, initial, change)
	                ref_table[ref_value] = initial + (destroyed_count * change)
                end,
                scaling_message = {
	                message = 'X'..card.ability.extra.x_mult..' Mult', 
                    colour = G.C.RED
                }
              })
              card:juice_up(0.6, 0.6)
          end
      end

      if context.joker_main then
          if card.ability.extra.x_mult and card.ability.extra.x_mult > 1 then
              return {
                  message = 'X'..card.ability.extra.x_mult..' Mult', 
                  Xmult_mod = card.ability.extra.x_mult,
                  card = card           
              }
          end
      end
  end
}
return { name = {"Jokers"}, items = {jeff_the_joker} }
