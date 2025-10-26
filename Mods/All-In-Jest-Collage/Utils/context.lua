local cash_out_ref = G.FUNCS.cash_out
G.FUNCS.cash_out = function(e)
  SMODS.calculate_context({
    cashing_out = true
  })

  cash_out_ref(e)
end
--Stuff for destruction effects
local start_dissolve_ref = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
  local ref = start_dissolve_ref(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
  if G.jokers and self.ability.set == 'Joker' then
    SMODS.calculate_context({
      jest_destroying_or_selling_joker = true,
      jest_destroyed_joker = self,
    })
    if self.ability.jest_sold_self == nil then
      SMODS.calculate_context({
      jest_destroying_joker = true,
      jest_destroyed_joker = self
     })
    end
  elseif (G.hand or G.play) and (self.ability.set == 'Enhanced' or self.ability.set == 'Default') then
    SMODS.calculate_context({
      jest_destroying_or_selling_card = true,
      jest_destroyed_card = self,
    })
    if self.ability.jest_sold_self == nil then
      SMODS.calculate_context({
      jest_destroying_card = true,
      jest_destroyed_card = self
     })
    end
  end
end

-- Workshoping
-- context.chance_trigger.trigger (returns true when 1 in whatever chance is true and false when it fails) 
-- context.chance_trigger.chances (The denomator of the triggered chance)