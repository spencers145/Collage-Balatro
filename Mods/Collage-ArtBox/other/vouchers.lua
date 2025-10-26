SMODS.Voucher({
	key = "pen_holder",
	atlas = "vouchers_atlas",
	pos = { x = 2, y = 0 },
	cost = 10,
	discovered = false,
	available = true,
    redeem = function(self)
		G.E_MANAGER:add_event(Event({
      func = function()
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
        return true
      end
    }))
	end,

    unredeem = function(self)
        G.E_MANAGER:add_event(Event({
      func = function()
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
        return true
      end
    }))
	end
})

SMODS.Voucher({
	key = "used_supplies",
	atlas = "vouchers_atlas",
	pos = { x = 3, y = 0 },
	cost = 10,
	discovered = false,
	available = true,
	loc_vars = function (self, info_queue, card)
		local n,d = SMODS.get_probability_vars(card, 1, 2, 'used_supplies')
		return { vars = { n, d }}
	end,
    requires = {'v_artb_pen_holder'},
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            for k, val in ipairs(context.removed) do
                
				if val.edition and SMODS.pseudorandom_probability(card, pseudorandom("supplies_edition"), 1, 2, 'supplies_edition') then
					G.E_MANAGER:add_event(Event({
						func = function()
							local collectable = ArtBox.create_collectable(val.edition.key)
							collectable:set_edition('e_negative')
							return true
						end
					}))
				end

				if val.seal and SMODS.pseudorandom_probability(card, pseudorandom("supplies_seal"), 1, 2, 'supplies_seal') then
					G.E_MANAGER:add_event(Event({
						func = function()
							local collectable = ArtBox.create_collectable(val.seal)
							collectable:set_edition('e_negative')
							return true
						end
					}))
				end

				if next(SMODS.get_enhancements(val)) and SMODS.pseudorandom_probability(card, pseudorandom("supplies_enhancement"), 1, 2, 'supplies_enhancement') then
					G.E_MANAGER:add_event(Event({
						func = function()
							local collectable = ArtBox.create_collectable(val.config.center.key)
							collectable:set_edition('e_negative')
							return true
						end
					}))
				end
            end
        end

        if context.cards_destroyed then
            for k, val in ipairs(context.glass_shattered) do
                
		if val.edition and SMODS.pseudorandom_probability(card, pseudorandom("supplies_edition"), 1, 2, 'supplies_edition') then
			G.E_MANAGER:add_event(Event({
				func = function()
					local collectable = ArtBox.create_collectable(val.edition.key)
                    collectable:set_edition('e_negative')
					return true
				end
			}))
		end

		if val.seal and SMODS.pseudorandom_probability(card, pseudorandom("supplies_seal"), 1, 2, 'supplies_seal') then
			G.E_MANAGER:add_event(Event({
				func = function()
					local collectable = ArtBox.create_collectable(val.seal)
                    collectable:set_edition('e_negative')
					return true
				end
			}))
		end

		if next(SMODS.get_enhancements(val)) and SMODS.pseudorandom_probability(card, pseudorandom("supplies_enhancement"), 1, 2, 'supplies_enhancement') then
			G.E_MANAGER:add_event(Event({
				func = function()
					local collectable = ArtBox.create_collectable(val.config.center.key)
                    collectable:set_edition('e_negative')
					return true
				end
			}))
		end
            end
        end
    end
})