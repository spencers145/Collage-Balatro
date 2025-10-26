SMODS.Consumable {
  key = 'gemini',
  name = 'Gemini',
  set = 'Constellation',
  atlas = "Constellations",
  pos = GetConstellationAtlasTable('gemini'),
  unlocked = true, 
  discovered = true,
  config = {
    extra_planets = 2
  },
  
  use = function(self, card, area, copier)
    for i = 1, math.min(card.ability.extra_planets, G.consumeables.config.card_limit - #G.consumeables.cards) do
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          if G.consumeables.config.card_limit > #G.consumeables.cards then
            play_sound('timpani')
            SMODS.add_card({ set = 'Planet' })
            card:juice_up(0.3, 0.5)
          end
          return true
        end
      }))
    end
    delay(0.6)
  end,

  can_use = function(self, card)
    return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit
  end
}