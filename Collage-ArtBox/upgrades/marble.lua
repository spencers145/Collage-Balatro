SMODS.Enhancement({
  key = "marble",
  atlas = "enhancers_atlas",
  pos = { x = 0, y = 1 },
  discovered = true,
  no_rank = true,
  no_suit = true,
  replace_base_card = true,
  always_scores = true,
  config = {
    x_chips = 1,
    extra = {
      progress = 0
    }
  },
  in_pool = function (self, args)
    return false
  end,

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.x_chips,
        card.ability.extra.progress,
      }
    }
  end,

  calculate = function(self, card, context)
    if context.final_scoring_step and context.cardarea == G.play and not context.debuffed and card.ability.extra.progress < 4 then
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        func = function()
          card.ability.extra.progress = card.ability.extra.progress + 1
          card:juice_up()

          if card.ability.extra.progress >= 4 then
            card.ability.x_chips = 2
          end
          return true
        end
      }))
    end
  end,

  draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
      if card.ability.extra.progress < 4 then
        card.children.center:set_sprite_pos({ x = card.ability.extra.progress, y = 1 })
      else
        card.children.center:set_sprite_pos({ x = 4, y = 1 })
      end
      
    end
  end
})

local card_isfaceref = Card.is_face

function Card:is_face(from_boss)
    if self.debuff and not from_boss then return end
	
	if self.config.center == G.P_CENTERS.m_artb_marble and self.ability.extra.progress >= 4 then
		return true
	end
	
	return card_isfaceref(self, from_boss)
end
