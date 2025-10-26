SMODS.Consumable ({
    object_type = "Consumable",
     atlas = 'arts_atlas',
	key = 'art_swatch',
	set = 'art',
	name = 'Swatch',
    config = {
    },
	pos = { x = 3, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = false,
    can_use = function(self, card)
		return true
	end,
    loc_vars = function(self, info_queue, card)
    end,

    use = function(self, card, area)
      local types = {}
      for _, v in pairs(SMODS.ConsumableTypes) do
        if v.key~="collectable" and v.key~="Cine" and ((v.key~="Spectral" and v.key~='Statement' and v.key~='Divine' and v.key~='BlackMarket' and v.key~='Polymino') or SMODS.pseudorandom_probability(card, pseudoseed('art_swatch_spectrals'), 1, 4, 'art_swatch_spectrals', true)) then
           types[#types + 1] = v
        end
      end
     G.E_MANAGER:add_event(Event({
        trigger = 'before',
        func = function()
          SMODS.add_card {
            set = pseudorandom_element(types, pseudoseed('Swatch')).key,
            area = G.consumables,
            edition = 'e_negative',
            soulable = true,
            key_append = 'Swatch',
          }

          return true
        end
      }))
    end

    
})