-- Echo Chamber
SMODS.Joker {
	key = "echo_chamber",
	rarity = 3,
	atlas = 'TextureAtlasJokers',
	pos = { x = 3, y = 2 },
	cost = 7,
	discovered = false,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
	loc_vars = function(self, info_queue, back)
		return { vars = { localize { type = 'name_text', key = 'tag_double', set = 'Tag' } } }
	end,
	calculate = function(self, back, context)
		if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.boss then
			G.E_MANAGER:add_event(Event({
				func = function()
					add_tag(Tag('tag_double'))
					play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
					play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
					return true
				end
			}))
		end
	end,
}